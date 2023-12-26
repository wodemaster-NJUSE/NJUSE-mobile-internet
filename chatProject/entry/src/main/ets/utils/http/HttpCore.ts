import http from '@ohos.net.http';
import { RequestOptions } from './RequestOptions';

/**
 * Http请求器
 */
export class HttpCore {

  /**
   * 发送请求
   * @param requestOption
   * @returns Promise
   */
  request<T>(requestOption: RequestOptions): Promise<T> {
    return new Promise<T>((resolve, reject) => {
      //----test
      console.info('http_core_send:' + requestOption.url + '' + requestOption.method.toString())
      //----
      this.sendRequest(requestOption)
        .then((response) => {
          if (typeof response.result !== 'string') {
            reject(new Error('Invalid data type'));

          } else {
            let bean: T = JSON.parse(response.result) as T;
            if (bean) {
              resolve(bean);
            } else {
              reject(new Error('Invalid data type,JSON to T failed'));
            }

          }
        })
        .catch((error) => {
          reject(error);
        });
    });
  }


  private sendRequest(requestOption: RequestOptions): Promise<http.HttpResponse> {
    // 每一个httpRequest对应一个HTTP请求任务，不可复用
    let httpRequest = http.createHttp();
    let resolveFunction, rejectFunction;
    const resultPromise = new Promise<http.HttpResponse>((resolve, reject) => {
      resolveFunction = resolve;
      rejectFunction = reject;
    });

    if (!this.isValidUrl(requestOption.url)) {
      return Promise.reject(new Error('url格式不合法.'));
    }

    let promise = httpRequest.request(
      requestOption.url,
      {
        method: requestOption.method,
        extraData: requestOption.extraData, // 当使用POST请求时此字段用于传递内容
        connectTimeout: 60000,
        // 可选，默认为60s
        readTimeout: 60000,
        header: requestOption.header,
        // expectDataType: http.HttpDataType.STRING // 可选，指定返回数据的类型
    });

    promise.then((response) => {

      console.info('Result:' + response.result);
      console.info('code:' + response.responseCode);
      console.info('header:' + JSON.stringify(response.header));


      if (http.ResponseCode.OK !== response.responseCode) {
        throw new Error('http responseCode !=200');
      }
      resolveFunction(response);

    }).catch((err) => {
      rejectFunction(err);
    }).finally(() => {
      // 当该请求使用完毕时，调用destroy方法主动销毁。
      httpRequest.destroy();
    })
    return resultPromise;
  }


  private appendQueryParams(url: string, queryParams: Record<string, string>): string {

    // todo 使用将参数拼接到url上
    return url;
  }

  private isValidUrl(url: string): boolean {

    //todo 实现URL格式判断
    return true;

  }
}

export const httpCore = new HttpCore();

export class ResponseResult {
  /**
   * Code returned by the network request: success, fail.
   */
  code: string;

  /**
   * Message returned by the network request.
   */
  // msg: string | Resource;
  msg : string;

  /**
   * Data returned by the network request.
   */
  data: string;

  constructor() {
    this.code = '';
    this.msg = '';
    this.data = '';
  }
}

