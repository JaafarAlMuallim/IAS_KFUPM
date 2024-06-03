import { config } from "dotenv";
import express from "express";
import OpenAI from "openai";
import { answerRouter } from "./routes/answer";
import { authRouter } from "./routes/auth";
import { chatRouter } from "./routes/chat";
import { goalRouter } from "./routes/goal";
import { messageRouter } from "./routes/message";
import { questionRouter } from "./routes/question";
import { userRouter } from "./routes/user";

const app = express();
const port = 8080;
config();

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.get("/", (req, res) => {
  res.send({
    state: "success",
    message: "running",
  });
});
app.use("/auth", authRouter);
app.use("/user", userRouter);
app.use("/question", questionRouter);
app.use("/chat", chatRouter);
app.use("/answer", answerRouter);
app.use("/goal", goalRouter);
app.use("/message", messageRouter);

app.listen(port, () => {
  console.log(`app listening at http://localhost:${port}`);
});

export { openai };
