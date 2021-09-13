/*
  Warnings:

  - You are about to drop the column `englishName` on the `Coffee` table. All the data in the column will be lost.
  - Added the required column `englishName` to the `CoffeeDetail` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Coffee` DROP COLUMN `englishName`;

-- AlterTable
ALTER TABLE `CoffeeDetail` ADD COLUMN `englishName` VARCHAR(191) NOT NULL;
