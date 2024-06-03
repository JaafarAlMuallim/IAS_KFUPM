import express from "express";
import { getUser, updateUser } from "../controllers/user";

const router = express.Router();

router.route("/").get(getUser).put(updateUser);

export { router as userRouter };
