import express from "express";
import { getChat, getChats, addChat, deleteChat } from "../controllers/chat";

const router = express.Router();

router.route("/").get(getChats).post(addChat);
router.route("/:id").get(getChat).delete(deleteChat);

export { router as chatRouter };
