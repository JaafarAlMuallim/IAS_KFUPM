import { and, eq } from "drizzle-orm";
import { NextFunction, Request, Response } from "express";
import db from "../db";
import { Chat, chat } from "../schema";

type ChatType = Omit<Chat, "chat_id" | "created_at">;

export async function getChat(req: Request, res: Response, next: NextFunction) {
  try {
    const { id } = req.params;
    const foundChat = await db.query.chat.findFirst({
      where: eq(chat.chat_id, id),
      with: {
        user: true,
        chatMessages: {
          orderBy: { created_at: "desc" },
          with: { role: true },
        },
      },
    });
    res.send(foundChat);
  } catch (err) {
    next(err);
  }
}

export async function addChat(req: Request, res: Response, next: NextFunction) {
  try {
    const newChat: ChatType = {
      user_id: req.headers.authorization?.split(" ")[1]!,
    };
    const addedChat = await db.insert(chat).values(newChat).returning();
    res.send(addedChat[0]);
  } catch (err) {
    next(err);
  }
}

export async function deleteChat(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const deletedChat = await db
      .delete(chat)
      .where(
        and(
          eq(chat.chat_id, id),
          eq(chat.user_id, req.headers.authorization!.split(" ")[1])
        )
      )
      .returning();
    res.send(deletedChat);
  } catch (err) {
    next(err);
  }
}

export async function getChats(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const chats = await db.query.chat.findMany({
      where: eq(chat.user_id, req.headers.authorization!.split(" ")[1]),
    });
    res.send(chats);
  } catch (err) {
    next(err);
  }
}
