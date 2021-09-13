require("dotenv").config();
import express, { urlencoded } from "express";
import { getCoffeeDetail, getCoffeeList, getDetail } from "./getData";
import productRouter from "./routers/productsRouter";

const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use("/products", productRouter);
getCoffeeDetail();
app.listen(4000, () => console.log(`server is running on ${process.env.PORT}`));
