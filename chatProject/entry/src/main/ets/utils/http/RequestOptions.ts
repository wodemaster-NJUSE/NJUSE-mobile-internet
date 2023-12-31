/**
 * <pre>
 * @desc  : 网络请求配置
 * </pre>
 */
import http from '@ohos.net.http';

export interface RequestOptions {

  /**
   * Request url.
   */
  url?: string;

  /**
   * Request method.
   */
  method?: RequestMethod; // default is GET

  /**
   * Request url queryParams  .
   */
  queryParams ?: Record<string, string>;

  /**
   * Additional data of the request.
   * extraData can be a string or an Object (API 6) or an ArrayBuffer(API 8).
   */
  extraData?: string | Object | ArrayBuffer;

  /**
   * HTTP request header.
   */
  header?: Object; // default is 'content-type': 'application/json'

}

export enum RequestMethod {
  OPTIONS = "OPTIONS",
  GET = "GET",
  HEAD = "HEAD",
  POST = "POST",
  PUT = "PUT",
  DELETE = "DELETE",
  TRACE = "TRACE",
  CONNECT = "CONNECT"
}


