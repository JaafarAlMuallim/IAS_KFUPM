import { and, eq } from "drizzle-orm";
import { NextFunction, Request, Response } from "express";
import db from "../db";
import { answer } from "../schema";

export async function getAnswer(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const foundAnswer = await db.query.answer.findFirst({
      where: eq(answer.answer_id, id),
      with: { user: true },
    });
    res.send(foundAnswer);
  } catch (err) {
    next(err);
  }
}

export async function getAnswers(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const foundAnswers = await db.query.answer.findMany({
      with: { user: true },
      where: eq(answer.question_id, req.params.question_id),
    });
    res.send(foundAnswers);
  } catch (err) {
    next(err);
  }
}

export async function addAnswer(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const newAnswer = {
      answer: req.body.answer,
      question_id: req.params.question_id,
      user_id: req.headers.authorization!.split(" ")[1],
    };
    const addedAnswer = await db.insert(answer).values([newAnswer]).returning();
    res.send(addedAnswer[0]);
  } catch (err) {
    next(err);
  }
}

export async function updateAnswer(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const updatedAnswer = await db
      .update(answer)
      .set({ answer: req.body.answer })
      .where(
        and(
          eq(answer.user_id, req.headers.authorization!.split(" ")[1]),
          eq(answer.answer_id, req.params.id)
        )
      )
      .returning();
    res.send(updatedAnswer);
  } catch (err) {
    next(err);
  }
}

export async function deleteAnswer(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const deletedAnswer = await db
      .delete(answer)
      .where(
        and(
          eq(answer.user_id, req.headers.authorization!.split(" ")[1]),
          eq(answer.answer_id, req.params.id)
        )
      )
      .returning();
    res.send(deletedAnswer);
  } catch (err) {
    next(err);
  }
}
