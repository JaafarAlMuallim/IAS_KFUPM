import express from "express";
import {
  addChatMessage,
  deleteChatMessages,
  getChatMessages,
} from "../controllers//message";

const router = express.Router();
router
  .route("/:id")
  .get(getChatMessages)
  .post(addChatMessage)
  .delete(deleteChatMessages);

export { router as messageRouter };
