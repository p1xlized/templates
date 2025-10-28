import { Elysia } from "elysia";
import { db } from "./db/db";
import { eq } from "drizzle-orm";
import { usersTable } from "./db/schema";

const app = new Elysia().get("/", () => "Hello Elysia").listen(5000);
async function main() {
  const user: typeof usersTable.$inferInsert = {
    name: "John",
    age: 30,
    email: "john@example.com",
  };

  const users = await db.select().from(usersTable);
  console.log("Getting all users from the database: ", users);
  /*
  const users: {
    id: number;
    name: string;
    age: number;
    email: string;
  }[]
  */

  await db
    .update(usersTable)
    .set({
      age: 31,
    })
    .where(eq(usersTable.email, user.email));
  console.log("User info updated!");

  await db.delete(usersTable).where(eq(usersTable.email, user.email));
  console.log("User deleted!");
}

main();
console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`,
);
