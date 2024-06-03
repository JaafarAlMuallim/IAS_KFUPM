import bcrypt from "bcrypt";
import { and, eq } from "drizzle-orm";
import { NextFunction, Request, Response } from "express";
import db from "../db";
import { User, user } from "../schema";

type UserType = Omit<User, "user_id">;

export async function signUp(req: Request, res: Response, next: NextFunction) {
  try {
    const encryptedPassword = bcrypt.hashSync(req.body.password, 10);
    const newUser: UserType = {
      name: req.body.name,
      email: req.body.email,
      contact_number: req.body.contact_number,
      password: encryptedPassword,
      birth_date: req.body.birth_date,
      role: "user",
    };
    const addedPerson = await db.insert(user).values([newUser]).returning();
    const { password, ...rest } = addedPerson[0];
    return res.send(rest);
  } catch (err) {
    next(err);
  }
}

export async function login(req: Request, res: Response, next: NextFunction) {
  try {
    const { email, password } = req.body;
    const foundUser = await db.query.user.findFirst({
      where: and(eq(user.email, email)),
    });
    if (foundUser) {
      const isPasswordCorrect = bcrypt.compareSync(
        password,
        foundUser.password
      );
      if (isPasswordCorrect) {
        const { password, ...rest } = foundUser;
        res.send(rest);
      }
    } else {
      return res.status(404).send("User not found");
    }
  } catch (err) {
    next(err);
  }
}
