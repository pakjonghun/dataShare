/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `Category` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `Coffee` DROP FOREIGN KEY `Coffee_categoryId_fkey`;

-- DropForeignKey
ALTER TABLE `CoffeeDetail` DROP FOREIGN KEY `CoffeeDetail_coffeeId_fkey`;

-- CreateIndex
CREATE UNIQUE INDEX `Category_name_key` ON `Category`(`name`);

-- AddForeignKey
ALTER TABLE `Coffee` ADD CONSTRAINT `Coffee_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CoffeeDetail` ADD CONSTRAINT `CoffeeDetail_coffeeId_fkey` FOREIGN KEY (`coffeeId`) REFERENCES `Coffee`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
