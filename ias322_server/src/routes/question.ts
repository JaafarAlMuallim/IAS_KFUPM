import express from "express";
import {
  getQuestion,
  getAllQuestions,
  addQuestion,
  updateQuestion,
  deleteQuestion,
} from "../controllers/question";

const router = express.Router();
router.route("/").get(getAllQuestions).post(addQuestion);
router
  .route("/:id")
  .get(getQuestion)
  .put(updateQuestion)
  .delete(deleteQuestion);

export { router as questionRouter };
