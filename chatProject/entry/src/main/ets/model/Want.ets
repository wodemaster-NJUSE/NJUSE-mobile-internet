export class WantModel {
  srcImage: string = '';
  textContent: string = '';
  senderId: number = 0;

  constructor(srcImage?: string, text?: string, senderId?: number) {
    if (srcImage !== undefined) {
      this.srcImage = srcImage;
    }
    if (text !== undefined) {
      this.textContent = text;
    }
    if (senderId !== undefined) {
      this.senderId = senderId;
    }
  }

  toString(): string {
    return this.srcImage + "  " + this.textContent + "  " + this.senderId;
  }
}

export class WantFileModel {
  fdImage: number = 0;
  kindId: number = 0;

  constructor(fdImage?: number, kindId?: number) {
    if (fdImage !== undefined) {
      this.fdImage = fdImage;
    }

    if (kindId !== undefined) {
      this.kindId = kindId;
    }
  }
}

export class ShareDate {
  type: string = '';
  value: number = 0;
}
