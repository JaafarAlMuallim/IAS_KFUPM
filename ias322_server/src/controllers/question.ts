import { and, eq } from "drizzle-orm";
import { NextFunction, Request, Response } from "express";
import db from "../db";
import { Question, question } from "../schema";

type NewQuestion = Omit<Question, "question_id" | "created_at">;

export async function getAllQuestions(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const foundQuestions = await db.query.question.findMany();
    console.log(foundQuestions);
    res.send(foundQuestions);
  } catch (err) {
    next(err);
  }
}

export async function getQuestion(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const foundQuestion = await db.query.question.findFirst({
      where: eq(question.question_id, id),
      with: {
        user: true,
        answers: {
          orderBy: { created_at: "desc" },
          with: { user: true },
        },
      },
    });
    res.send(foundQuestion);
  } catch (err) {
    next(err);
  }
}

export async function addQuestion(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const newQuestion: NewQuestion = {
      title: req.body.title,
      question: req.body.question,
      user_id: req.headers.authorization?.split(" ")[1]!,
    };

    const addedQuestion = await db
      .insert(question)
      .values([newQuestion])
      .returning();

    res.send(addedQuestion[0]);
  } catch (err) {
    next(err);
  }
}

export async function updateQuestion(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const updatedQuestion = await db
      .update(question)
      .set(req.body)
      .where(
        and(
          eq(question.question_id, id),
          eq(question.user_id, req.headers.authorization!.split(" ")[1])
        )
      )
      .returning();
    res.send(updatedQuestion);
  } catch (err) {
    next(err);
  }
}

export async function deleteQuestion(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const deletedQuestion = await db
      .delete(question)
      .where(
        and(
          eq(question.question_id, id),
          eq(question.user_id, req.headers.authorization!.split(" ")[1])
        )
      )
      .returning();
    res.send(deletedQuestion);
  } catch (err) {
    next(err);
  }
}
