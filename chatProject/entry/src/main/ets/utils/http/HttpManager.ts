import { RequestOptions } from './RequestOptions';
import { httpCore as HttpCore } from './HttpCore';
/**
 * <pre>
 * @desc       : 对外管理器
 * </pre>
 */
export class HttpManager {
  private static mInstance: HttpManager;

  // 防止实例化
  private constructor() {
  }

  static getInstance(): HttpManager {
    if (!HttpManager.mInstance) {
      HttpManager.mInstance = new HttpManager();
    }
    return HttpManager.mInstance;
  }

  request<T>(option: RequestOptions): Promise<T> {
    return HttpCore.request(option);
  }
}

