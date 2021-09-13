import express from "express";
const productRouter = express.Router();

productRouter.get("/categories");

export default productRouter;
