
import 'dart:ffi';
import 'package:ffi/ffi.dart';

final _shell32 = DynamicLibrary.open('shell32.dll');

final _shellExecuteW = _shell32.lookupFunction<
  IntPtr Function(
    IntPtr hwnd,
    Pointer<Utf16> lpOperation,
    Pointer<Utf16> lpFile,
    Pointer<Utf16> lpParameters,
    Pointer<Utf16> lpDirectory,
    Int32 nShowCmd
  ),
  int Function(
    int hwnd,
    Pointer<Utf16> lpOperation,
    Pointer<Utf16> lpFile,
    Pointer<Utf16> lpParameters,
    Pointer<Utf16> lpDirectory,
    int nShowCmd
  )>('ShellExecuteW');

int shellExecute({
  String operation = 'open',
  required String file,
  String? params,
  String? dir
}) {

  Pointer<Utf16> lpOperation = operation.toNativeUtf16();
  Pointer<Utf16> lpFile = file.toNativeUtf16();
  Pointer<Utf16> lpParameters = params?.toNativeUtf16() ?? nullptr;
  Pointer<Utf16> lpDirectory = dir?.toNativeUtf16() ?? nullptr;

  int result = _shellExecuteW(0, lpOperation, lpFile, lpParameters, lpDirectory, 1);

  malloc.free(lpOperation);
  malloc.free(lpFile);
  if(lpParameters != nullptr) malloc.free(lpParameters);
  if(lpDirectory != nullptr) malloc.free(lpDirectory);

  return result;

}
