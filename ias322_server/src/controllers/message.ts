import { and, asc, eq } from "drizzle-orm";
import { NextFunction, Request, Response } from "express";
import { openai } from "../app";
import db from "../db";
import { ChatMessages, chatMessages } from "../schema";
type InsertChatMessage = Omit<ChatMessages, "chat_messages_id" | "created_at">;

type SendMessage = {
  role: "user" | "assistant";
  content: string;
};

export async function getChatMessages(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const foundChatMessages = await db
      .selectDistinct()
      .from(chatMessages)
      .orderBy(asc(chatMessages.created_at))
      .where(
        and(
          eq(chatMessages.chat_id, req.params.id),
          eq(chatMessages.user_id, req.headers.authorization!.split(" ")[1])
        )
      );
    res.send(foundChatMessages);
  } catch (err) {
    next(err);
  }
}

export async function getChatMessagesServer(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const foundChatMessages = await db
      .selectDistinct()
      .from(chatMessages)
      .orderBy(asc(chatMessages.created_at))
      .where(eq(chatMessages.chat_id, req.params.id));

    return foundChatMessages;
  } catch (err) {
    next(err);
  }
}

export async function addChatMessage(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const allMessages = await getChatMessagesServer(req, res, next);
    const messages: SendMessage[] | undefined = [];
    if (allMessages) {
      allMessages?.map((message: ChatMessages) => {
        messages.push({
          role: message.role == "AI" ? "assistant" : "user",
          content: message.message,
        });
      });
    }
    const { id } = req.params;

    const response = await openai.chat.completions.create({
      messages: [
        {
          role: "system",
          content:
            "You are a consultant to students who might have failed a course, they can ask you about their carrer, studies, and you are a helpful assistant, Answer in Arabic.",
        },
        ...(messages as []),
        { role: "user", content: req.body.message },
      ],
      model: "gpt-3.5-turbo",
    });

    const newChatMessage: InsertChatMessage = {
      message: req.body.message,
      chat_id: id,
      user_id: req.headers.authorization!.split(" ")[1],
      role: "user",
    };

    const newChatGptMessage: InsertChatMessage = {
      message: response.choices[0].message.content!,
      user_id: req.headers.authorization!.split(" ")[1],
      chat_id: id,
      role: "AI",
    };
    const addMyMsg = await db
      .insert(chatMessages)
      .values(newChatMessage)
      .returning();

    const addedChatMessage = await db
      .insert(chatMessages)
      .values(newChatGptMessage)
      .returning();

    res.send(addedChatMessage[0]);
  } catch (err) {
    next(err);
  }
}

export async function deleteChatMessages(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const deletedChatMessages = await db
      .delete(chatMessages)
      .where(
        and(
          eq(chatMessages.chat_id, id),
          eq(chatMessages.user_id, req.headers.authorization!.split(" ")[1])
        )
      )
      .returning();
    res.send(deletedChatMessages);
  } catch (err) {
    next(err);
  }
}
