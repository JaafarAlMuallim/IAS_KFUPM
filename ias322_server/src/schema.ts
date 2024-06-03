import { InferModel, relations, sql } from "drizzle-orm";
import {
  date,
  integer,
  pgEnum,
  pgTable,
  text,
  timestamp,
  uuid,
  varchar,
} from "drizzle-orm/pg-core";

export const chatUser = pgEnum("chat_user", ["AI", "user"]);

export const user = pgTable("user", {
  user_id: uuid("user_id")
    .primaryKey()
    .default(sql`gen_random_uuid()`),
  name: varchar("name", { length: 255 }).notNull(),
  email: varchar("email", { length: 255 }).notNull().unique(),
  birth_date: date("birth_date").notNull(),
  contact_number: varchar("contact_number", { length: 12 }).notNull(),
  password: varchar("password", { length: 255 }).notNull(),
  role: chatUser("role").notNull().default("user"),
});

export const chat = pgTable("chat", {
  chat_id: uuid("chat_id")
    .primaryKey()
    .default(sql`gen_random_uuid()`),
  user_id: uuid("user_id")
    .notNull()
    .references(() => user.user_id),
  created_at: date("created_at")
    .notNull()
    .default(sql`now()`),
});

export const chatMessages = pgTable("chat_messages", {
  chat_messages_id: uuid("chat_messages_id")
    .primaryKey()
    .default(sql`gen_random_uuid()`),
  message: text("message").notNull(),
  chat_id: uuid("chat_id")
    .notNull()
    .references(() => chat.chat_id),
  user_id: uuid("user_id")
    .notNull()
    .references(() => user.user_id),
  created_at: timestamp("created_at", {
    precision: 6,
    withTimezone: true,
  }).default(sql`now()`),
  role: chatUser("role").notNull().default("user"),
});

export const goal = pgTable("goal", {
  goal_id: uuid("goal_id")
    .primaryKey()
    .default(sql`gen_random_uuid()`),
  title: varchar("title", { length: 255 }).notNull(),
  target: integer("target").notNull(),
  done: integer("done").notNull().default(0),
  user_id: uuid("user_id")
    .notNull()
    .references(() => user.user_id),
});

export const userGoalRelation = relations(user, ({ many }) => ({
  goals: many(goal),
}));

export const goalUserRelation = relations(goal, ({ one }) => ({
  user: one(user, {
    fields: [goal.user_id],
    references: [user.user_id],
  }),
}));

export const chatMessagesRelation = relations(chat, ({ many }) => ({
  chatMessages: many(chatMessages),
}));

export const messageChatRelation = relations(chatMessages, ({ one }) => ({
  chat: one(chat, {
    fields: [chatMessages.chat_id],
    references: [chat.chat_id],
  }),
}));

export const userChatMessagesRelation = relations(user, ({ many }) => ({
  chatMessages: many(chatMessages),
}));

export const chatMessagesUserRelation = relations(chatMessages, ({ one }) => ({
  user: one(user, {
    fields: [chatMessages.user_id],
    references: [user.user_id],
  }),
}));

export const question = pgTable("question", {
  question_id: uuid("question_id")
    .primaryKey()
    .default(sql`gen_random_uuid()`),
  title: varchar("title", { length: 255 }).notNull(),
  question: varchar("question", { length: 255 }).notNull(),
  created_at: date("created_at")
    .notNull()
    .default(sql`now()`),
  user_id: uuid("user_id")
    .notNull()
    .references(() => user.user_id),
});

export const answer = pgTable("answer", {
  answer_id: uuid("answer_id")
    .primaryKey()
    .default(sql`gen_random_uuid()`),
  answer: text("answer").notNull(),
  question_id: uuid("question_id")
    .notNull()
    .references(() => question.question_id),
  created_at: date("created_at")
    .notNull()
    .default(sql`now()`),
  user_id: uuid("user_id")
    .notNull()
    .references(() => user.user_id),
});

export const userChatRelation = relations(chat, ({ one }) => ({
  user: one(user, {
    fields: [chat.user_id],
    references: [user.user_id],
  }),
}));
export const chatUserRelation = relations(user, ({ many }) => ({
  chats: many(chat),
}));

export const questionAnswerRelation = relations(answer, ({ one }) => ({
  question: one(question, {
    fields: [answer.question_id],
    references: [question.question_id],
  }),
}));

export const answerQuestionRelation = relations(question, ({ many }) => ({
  answers: many(answer),
}));

export const questionPersonRelation = relations(question, ({ one }) => ({
  user: one(user, {
    fields: [question.user_id],
    references: [user.user_id],
  }),
}));
export const personQuestionRelation = relations(question, ({ one }) => ({
  user: one(user, {
    fields: [question.user_id],
    references: [user.user_id],
  }),
}));
export const personAnswerRelation = relations(answer, ({ one }) => ({
  user: one(user, {
    fields: [answer.user_id],
    references: [user.user_id],
  }),
}));

export const answerPersonRelation = relations(user, ({ many }) => ({
  answers: many(answer),
}));

export type User = InferModel<typeof user>;
export type Chat = InferModel<typeof chat>;
export type Question = InferModel<typeof question>;
export type Answer = InferModel<typeof answer>;
export type ChatMessages = InferModel<typeof chatMessages>;
export type Goal = InferModel<typeof goal>;
