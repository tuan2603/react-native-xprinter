import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-xprinter' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const Xprinter = NativeModules.Xprinter
  ? NativeModules.Xprinter
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return Xprinter.multiply(a, b);
}

export function discovery(connType: number): Promise<string> {
  return Xprinter.discovery(connType);
}

export function connect(connType: number, address: string): Promise<boolean> {
  return Xprinter.connect(connType, address);
}

export function printBitmap(base64: string) {
  return Xprinter.printBitmap(base64);
}

export function openCashBox() {
  return Xprinter.openCashBox();
}

export function printerStatus(): Promise<number> {
  return Xprinter.printerStatus();
}

export function isConnect(): Promise<boolean> {
  return Xprinter.isConnect();
}

export function setIp(ipAddress: String): Promise<boolean> {
  return Xprinter.setIp(ipAddress);
}
