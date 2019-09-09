const puppeteer = require('puppeteer');

(async() => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.goto('https://www.youtube.com/channel/UCDh2bWI5EDu7PavqwICkVpA/community');
  // await page.waitFor(10000);
  //await page.screenshot({path: 'mico.png', fullPage: true});
  //await console.log("screenshot");

  const scrapingData = await page.evaluate(() => {
    const dataList = [];
    const nodeList =  document.querySelectorAll("#published-time-text a");
  
    nodeList.forEach(_node => {
      dataList.push(_node.getAttribute("href"));
    });
  
    return dataList;
  });

  console.log(scrapingData);
  await browser.close();
})();
