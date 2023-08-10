import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppFormatter {
  static final phone = MaskTextInputFormatter(filter: {"#": RegExp(r'[0-9]')}, mask: '+90 ### ### ## ##', type: MaskAutoCompletionType.lazy);

  static final iban = MaskTextInputFormatter(filter: {"#": RegExp(r'[0-9]')}, mask: 'TR## #### #### #### #### #### ##', type: MaskAutoCompletionType.lazy);

  static final creditCardNumber = MaskTextInputFormatter(filter: {"#": RegExp(r'[0-9]')}, mask: '#### #### #### ####', type: MaskAutoCompletionType.lazy);

  static final creditCardCvv = MaskTextInputFormatter(filter: {"#": RegExp(r'[0-9]')}, mask: '###', type: MaskAutoCompletionType.lazy);

  static final creditCardExpiredDate = MaskTextInputFormatter(filter: {"#": RegExp(r'[0-9]')}, mask: '## / ##', type: MaskAutoCompletionType.lazy);
}
