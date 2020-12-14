package com.napt.ui.gap.pages;

import com.napt.framework.ui.interactions.Clicks;
import com.napt.framework.ui.interactions.DropDowns;
import com.napt.framework.ui.interactions.Element;
import com.napt.framework.ui.interactions.Wait;
import com.napt.framework.ui.utils.StepUtils;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebElement;

import java.util.List;

public class PDP {

    public void closeOfferDialog(){
        Clicks.clickIfPresent("search.openOfferDialogBtn");
        Clicks.clickIfPresent("search.closeOfferDialogBtn");
    }

    public void checkout(){
        Wait.secondsUntilElementToBeClickable("product_page.checkoutBtn",10);
        Clicks.click("product_page.checkoutBtn");
    }
    public void addToBag()throws Exception{
            closeOfferDialog();
            if(StepUtils.MEW()){
                DropDowns.selectByText("product_page.qty","3");
//                Clicks.scrollToLazyLoadElement("product_page.color");
                Element.getRandomElement("product_page.color", webElement -> webElement.isDisplayed()).click();
//                Clicks.scrollToLazyLoadElement("product_page.size");
                Element.getRandomElement("product_page.size", webElement -> webElement.isDisplayed()).click();
            }else{
                Clicks.randomJavascriptClick("product_page.color");
                Clicks.randomJavascriptClick("product_page.size");
                Wait.secondsUntilElementSelectionStateToBe("product_page.qty",true,5);
                Clicks.click("product_page.qtybtn");
                List<WebElement> listQty = Element.findElements("product_page.qty");
                for(WebElement we:listQty){
                    try{
                        if (we.getText().equals("3")) {
                            we.click();
                        }
                    }catch(StaleElementReferenceException e){
                        System.out.println(e.getMessage());
                    }

                }

            }


            Clicks.javascriptClick("product_page.addtoBagBtn");


    }
}
