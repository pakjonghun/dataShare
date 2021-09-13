/*
  Warnings:

  - You are about to drop the column `name` on the `Coffee` table. All the data in the column will be lost.
  - Added the required column `coffeeDetailId` to the `Coffee` table without a default value. This is not possible if the table is not empty.
  - Added the required column `englishName` to the `Coffee` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageUrl` to the `Coffee` table without a default value. This is not possible if the table is not empty.
  - Added the required column `koreanName` to the `Coffee` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Coffee` DROP COLUMN `name`,
    ADD COLUMN `categoryId` INTEGER,
    ADD COLUMN `coffeeDetailId` INTEGER NOT NULL,
    ADD COLUMN `englishName` VARCHAR(191) NOT NULL,
    ADD COLUMN `imageUrl` VARCHAR(191) NOT NULL,
    ADD COLUMN `koreanName` VARCHAR(191) NOT NULL;

-- CreateTable
CREATE TABLE `Category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CoffeeDetail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `coffeeId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Coffee` ADD CONSTRAINT `Coffee_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CoffeeDetail` ADD CONSTRAINT `CoffeeDetail_coffeeId_fkey` FOREIGN KEY (`coffeeId`) REFERENCES `Coffee`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
