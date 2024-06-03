import express from "express";
import {
  addAnswer,
  deleteAnswer,
  getAnswer,
  getAnswers,
  updateAnswer,
} from "../controllers/answer";

const router = express.Router();
router.route("/:question_id").post(addAnswer);
router.route("/:question_id").get(getAnswers);
router.route("/:id").get(getAnswer).put(updateAnswer).delete(deleteAnswer);

export { router as answerRouter };
