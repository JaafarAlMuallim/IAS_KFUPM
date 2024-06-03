import { eq } from "drizzle-orm";
import { NextFunction, Request, Response } from "express";
import { user } from "../schema";
import db from "../db";

export async function getUser(req: Request, res: Response, next: NextFunction) {
  try {
    // id from headers
    const foundUser = await db.query.user.findFirst({
      where: eq(user.user_id, req.headers.authorization!.split(" ")[1]),
    });
    const { password, ...rest } = foundUser!;
    res.send(rest);
  } catch (err) {
    next(err);
  }
}

export async function updateUser(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const updatedPerson = await db
      .update(user)
      .set(req.body)
      .where(eq(user.user_id, req.headers.authorization!.split(" ")[1]))
      .returning();
    res.send(updatedPerson);
  } catch (err) {
    next(err);
  }
}

export async function getUsers(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const persons = await db.query.user.findMany();
    res.send(persons);
  } catch (err) {
    next(err);
  }
}
