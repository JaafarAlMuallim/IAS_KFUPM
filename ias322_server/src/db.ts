import { config } from "dotenv";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

config();
const dbUrl = process.env.DB_URL;
if (!dbUrl) throw new Error("DB_URL not set");
const client = postgres(dbUrl);
const db = drizzle(client, { schema });
export default db;
