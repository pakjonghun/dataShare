/*
  Warnings:

  - Made the column `categoryId` on table `Coffee` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `Coffee` DROP FOREIGN KEY `Coffee_categoryId_fkey`;

-- AlterTable
ALTER TABLE `Coffee` MODIFY `categoryId` INTEGER NOT NULL,
    MODIFY `coffeeDetailId` INTEGER;

-- AddForeignKey
ALTER TABLE `Coffee` ADD CONSTRAINT `Coffee_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
