import { and, eq } from "drizzle-orm";
import { NextFunction, Request, Response } from "express";
import db from "../db";
import { goal } from "../schema";

export async function getGoals(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const foundGoal = await db.query.goal.findMany({
      where: eq(goal.user_id, req.headers.authorization?.split(" ")[1]!),
    });
    res.send(foundGoal);
  } catch (err) {
    next(err);
  }
}

export async function addGoal(req: Request, res: Response, next: NextFunction) {
  try {
    const newGoal = {
      title: req.body.title,
      user_id: req.headers.authorization?.split(" ")[1]!,
      target: Number.parseInt(req.body.target),
      done: 0,
    };
    const addedGoal = await db.insert(goal).values([newGoal]).returning();
    res.send(addedGoal);
  } catch (err) {
    next(err);
  }
}

export async function updateGoal(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const updatedGoal = await db
      .update(goal)
      .set(req.body)
      .where(
        and(
          eq(goal.goal_id, id),
          eq(goal.user_id, req.headers.authorization!.split(" ")[1])
        )
      )
      .returning();
    res.send(updatedGoal[0]);
  } catch (err) {
    next(err);
  }
}

export async function deleteGoal(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const { id } = req.params;
    const deletedGoal = await db
      .delete(goal)
      .where(
        and(
          eq(goal.goal_id, id),
          eq(goal.user_id, req.headers.authorization!.split(" ")[1])
        )
      )
      .returning();
    res.send(deletedGoal);
  } catch (err) {
    next(err);
  }
}
