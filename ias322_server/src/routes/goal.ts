import express from "express";
import { addGoal, deleteGoal, getGoals, updateGoal } from "../controllers/goal";

const router = express.Router();

router.route("/").get(getGoals).post(addGoal);
router.route("/:id").put(updateGoal).delete(deleteGoal);

export { router as goalRouter };
