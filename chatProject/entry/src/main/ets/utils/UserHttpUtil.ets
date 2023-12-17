/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import http from '@ohos.net.http';
import { ResponseUserResult, UserData } from '../stores/user';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 */
export function httpRequestGetUser(url: string, userdata:UserData): Promise<ResponseUserResult> {
  //
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,//get方法
    header: {
      'Content-Type': 'application/json'
    },
    extraData: {
      'username': userdata.username,
      'password': userdata.password
    }
  });
  let serverData: ResponseUserResult = new ResponseUserResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === 200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseUserResult = JSON.parse(result);
      if (resultJson.code === 'success') {
        serverData.data = resultJson.data;// 返回给
        // 成功返回user对象

      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
      // 以上是构造返回给后端的信息
    } else {
      serverData.msg = 'error';
    }
    return serverData;
  }).catch(() => {
    serverData.msg = 'error';
    return serverData;
  })
}
export function httpRequestPostUser(url: string,user : UserData) : Boolean{
  //同过url和user对象发起post
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.POST,//post方法

    header: {
      'Content-Type': 'application/json'
    },
    extraData: {
      'username': user.username,
      'password': user.password
    }
  });
  //5.处理响应结果
  responseResult.then((data) => {
    //TODO:根据不同responseCode来返回
  if (data.responseCode === http.ResponseCode.OK) {
    console.info('Result:' + data.result);
    console.info('code:' + data.responseCode);
    return true;
  }
  }).catch((err) => {
  console.info('error:' + JSON.stringify(err));
  });
  return false;
}