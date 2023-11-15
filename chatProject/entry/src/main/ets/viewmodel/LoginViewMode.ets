import { ListItemData } from '../common/bean/ListItemData';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Login view model, providing page display data.
 */
class LoginViewMode {
  /**
   * Get personal information of MainPage.
   *
   * @return {Array<ListItemData>} personalListItems.
   */
  getPersonalListItems(): Array<ListItemData> {
    let personalListItems: Array<ListItemData> = [];
    for (let index = 1; index <= CommonConstants.LIST_SIZE; index++) {
      let personalListItem = new ListItemData();
      personalListItem.title = $r('app.string.component_list_item_text', index);
      personalListItems.push(personalListItem);
    }
    return personalListItems;
  }

  /**
   * Get contact information of CustomerServicePage.
   *
   * @return {Array<ListItemData>} contactListItems.
   */
  getContactListItems(): Array<ListItemData> {
    let contactListItems: Array<ListItemData> = [];
    let serviceHotline = new ListItemData();
    serviceHotline.title = $r('app.string.service_hotline');
    serviceHotline.summary = $r('app.string.hotline_number');
    contactListItems.push(serviceHotline);
    let emailAddress = new ListItemData();
    emailAddress.title = $r('app.string.email');
    emailAddress.summary = $r('app.string.email_address');
    contactListItems.push(emailAddress);
    return contactListItems;
  }
}

let loginViewMode = new LoginViewMode();

export default loginViewMode as LoginViewMode;