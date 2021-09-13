import fs from "fs";
import client from "./db";
import data from "./data.json";
import webdriver, { Builder, until } from "selenium-webdriver";
import chrome from "selenium-webdriver/chrome";
import { By } from "selenium-webdriver";

const seleniumBase = async (url) => {
  const service = new chrome.ServiceBuilder(
    "/Applications/chromedriver"
  ).build();

  chrome.setDefaultService(service);

  let driver = new Builder()
    .forBrowser("chrome")
    .setChromeOptions(new chrome.Options().headless())
    .build();

  await driver.get(url);
  return driver;
};

export const getCategory = async () => {
  try {
    for (let { name } of data.categories) {
      await client.category.create({
        data: {
          name,
        },
      });
    }
  } catch (e) {
    console.log(e);
  }
};

export const getCoffeeList = async () => {
  try {
    const driver = await seleniumBase(
      "https://www.starbucks.co.kr/menu/drink_list.do"
    );

    const bodyList = await driver.findElements(
      By.css(
        "#container > div.content > div.product_result_wrap.product_result_wrap01 > div > dl > dd:nth-child(2) > div.product_list > dl>dd"
      )
    );

    const arr = { coffeeList: [] };
    for (let i = 0; i < bodyList.length; i++) {
      const img = await bodyList[i].findElements(By.css("img"));
      for (let jtem of img) {
        const koreanName = await jtem.getAttribute("alt");
        const imgUrl = await jtem.getAttribute("src");
        arr.coffeeList.push({ imgUrl, koreanName });

        //여기서 db에 넣으면됨.
      }
    }

    const abcJson = JSON.stringify(arr);
    fs.writeFileSync("abc.json", abcJson);
  } catch (e) {
    console.log(e);
  }
};

export const getCoffeeDetail = async () => {
  try {
    const driver = await seleniumBase(
      "https://www.starbucks.co.kr/menu/drink_list.do"
    );

    const bodyList = await driver.findElements(
      By.css(
        "#container > div.content > div.product_result_wrap.product_result_wrap01 > div > dl > dd:nth-child(2) > div.product_list > dl>dd"
      )
    );

    const adress = [];
    for (let i = 0; i < bodyList.length; i++) {
      const props = await bodyList[i].findElements(By.css("a"));
      for (let jtem of props) {
        const id = await jtem.getAttribute("prod");
        const baseUrl = `https://www.starbucks.co.kr/menu/drink_view.do?product_cd=${id}`;
        adress.push(baseUrl);
      }
    }

    const details = { nutral: [] };
    for (let item of adress) {
      await driver.navigate().to(item);
      // const nameDom = await driver.findElement(
      //   By.css(
      //     "#container > div.content02 > div.product_view_wrap1 > div.product_view_detail > div.myAssignZone > h4 > span"
      //   )
      // );

      // const descDom = await driver.findElement(
      //   By.css(
      //     "#container > div.content02 > div.product_view_wrap1 > div.product_view_detail > div.myAssignZone > p"
      //   )
      // );

      // const nutrial = await driver.findElement(By.id("product_info01"));

      // const allergy = await driver.findElement(
      //   By.css(
      //     "#container > div.content02 > div.product_view_wrap1 > div.product_view_detail > form > fieldset > div > div.product_factor > p"
      //   )
      // );

      // const nutr = await nutrial.getText();
      // const aller = await allergy.getText();
      // const desc = await descDom.getText();
      // const englishName = await nameDom.getText();

      // details.coffeeDetail.push({ englishName, desc, aller, nutr });

      const lis = await driver.findElements(
        By.css(
          "#container > div.content02 > div.product_view_wrap1 > div.product_view_detail > form > fieldset > div > div.product_info_content > ul:nth-child(1) > li>dl"
        )
      );

      let i = 0;
      const temp = [];
      for (let ktem of lis) {
        i += 1;
        if (!(i % 5)) {
          details.nutral.push(temp);
        }
        const dt = await ktem.findElement(By.css("dt"));
        const dd = await ktem.findElement(By.css("dd"));

        const key = await dt.getText();
        const value = await dd.getText();

        if (!key.length) continue;
        temp.push({ key, value });
      }
    }
    const detailJson = JSON.stringify(details);
    fs.writeFileSync("nutral.json", detailJson);
    console.log("end!!");

    await driver.close();
  } catch (e) {
    console.log(e);
  }
};
