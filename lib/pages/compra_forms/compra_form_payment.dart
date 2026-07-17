import 'package:flutter/material.dart';
import 'package:flutter_ces/pages/compra_forms/order_success.dart';
import '../../components/stack_pages_route.dart';
import '../home_forms/demo.dart';
import 'package:provider/provider.dart';

import '../helpers/demo_data.dart';
import '../helpers/country_data.dart';
import '../../form_inputs/checkbox_input.dart';
import '../../form_inputs/credit_card_input.dart';
import '../helpers/form_mixin.dart';
import '../helpers/form_page.dart';
import '../../components/section_separator.dart';
import '../../components/section_title.dart';
import '../helpers/styles.dart';
import '../../components/submit_button.dart';
import '../../form_inputs/text_input.dart';

class CompraFormPayment extends StatefulWidget {
  final double? pageSize;

  const CompraFormPayment({Key? key, this.pageSize}) : super(key: key);

  @override
  State<CompraFormPayment> createState() => _CompraFormPaymentState();
}

class _CompraFormPaymentState extends State<CompraFormPayment> with FormMixin {
  final _formKey = GlobalKey<FormState>();
  CreditCardNetwork? _cardNetwork;

  late SharedFormState sharedState;
  Map<String, String> get values => sharedState.valuesByName;

  @override
  void initState() {
    sharedState = Provider.of<SharedFormState>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormPage(
      formKey: _formKey,
      pageSizeProportion: widget.pageSize ?? 0.85,
      title: 'Pago',
      children: [
        Text('\$34.00', style: FormStyles.orderTotal),
        const Separator(),
        _buildShippingSection(),
        const Separator(),
        const FormSectionTitle('Tarjeta de regalo o codigo de descuento'),
        _buildInputWithButton(),
        const FormSectionTitle('Pago', padding: EdgeInsets.only(bottom: 16)),
        CreditCardInfoInput(
          key: ValueKey(FormKeys.ccNumber),
          label: 'Numero de Tarjeta',
          helper: '4111 2222 3333 4440',
          cardNetwork: _cardNetwork,
          onValidate: onItemValidate,
          onChange: _handleItemChange,
          inputType: CreditCardInputType.number,
        ),
        TextInput(
          key: ValueKey(FormKeys.ccName),
          label: 'Nombre de Tarjeta',
          helper: 'Nombre',
          onValidate: onItemValidate,
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: CreditCardInfoInput(
              key: ValueKey(FormKeys.ccExpDate),
              label: 'Fecha de Expiracion',
              helper: 'MM/YY',
              onValidate: onItemValidate,
              inputType: CreditCardInputType.expirationDate,
            )),
            const SizedBox(width: 24),
            Expanded(
              child: CreditCardInfoInput(
                  key: ValueKey(FormKeys.ccCode),
                  cardNetwork: _cardNetwork,
                  label: 'Codigo de Seguridad',
                  helper: '000',
                  onValidate: onItemValidate,
                  inputType: CreditCardInputType.securityCode),
            ),
          ],
        ),
        const FormSectionTitle('Notificaciones de Compra'),
        const CheckBoxInput(label: 'Enviar actualizaciones de compra\n al Email'),
        _buildSubmitButton()
      ],
    );
  }

  @override
  void onItemValidate(String key, bool isValid, {String? value}) {
    validInputsMap[key] = isValid;
    values[key] = value ?? '';

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted) {
          setState(() {
            formCompletion = super.countValidItems() / validInputsMap.length;
            if (formCompletion == 1) isFormErrorVisible = false;
          });
        }
      },
    );
  }

  Widget _buildShippingSection() {
    return Column(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              constraints: const BoxConstraints(minWidth: 85),
              child: Text('Contacto', style: FormStyles.orderLabel)),
          Text(values[FormKeys.email] ?? '',
              overflow: TextOverflow.clip, style: FormStyles.orderPrice),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                constraints: const BoxConstraints(minWidth: 85),
                child: Text('Enviar a', style: FormStyles.orderLabel)),
            Text(_getShippingAddress(),
                overflow: TextOverflow.clip, style: FormStyles.orderPrice),
          ],
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              constraints: const BoxConstraints(minWidth: 85),
              child: Text('Metodo', style: FormStyles.orderLabel)),
          Text('GRATIS', overflow: TextOverflow.clip, style: FormStyles.orderPrice),
        ],
      )
    ]);
  }

  String _getShippingAddress() {
    String? aptNumber = values[FormKeys.apt]?.isNotEmpty == true
        ? '#${values[FormKeys.apt]} '
        : '';
    String? address = values[FormKeys.address];
    String? country = values[FormKeys.country];
    String? city = values[FormKeys.city];
    String? countrySubdivision =
        values[CountryData.getSubdivisionTitle(country)] ?? '';
    String? postalCode = values[FormKeys.postal];
    return '$aptNumber$address\n$city, $countrySubdivision ${postalCode?.toUpperCase()}\n${country?.toUpperCase()}';
  }

  Widget _buildInputWithButton() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 4,
            child: TextInput(
              key: ValueKey(FormKeys.coupon),
              helper: '000 000 000 XX',
              type: InputType.number,
              onValidate: onItemValidate,
              isRequired: false,
              isActive: false,
            )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 26.0, left: 12),
            child: MaterialButton(
              disabledColor: FormStyles.lightGrayColor,
              elevation: 0,
              color: FormStyles.secondaryColor,
              height: 56,
              onPressed: null,
              child: Text('Aplicar', style: FormStyles.submitButtonText),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SubmitButton(
      percentage: formCompletion,
      isErrorVisible: isFormErrorVisible,
      onPressed: _handleSubmit,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Comprar', style: FormStyles.submitButtonText),
            Text('\$70', style: FormStyles.submitButtonText),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true && formCompletion == 1) {
      Navigator.push(
        context,
        StackPagesRoute(
          previousPages: [const CompraFormPayment(pageSize: .85)],
          enterPage: const OrderSuccessPage(),
        ),
      );
    } else {
      setState(() => isFormErrorVisible = true);
    }
  }

  void _handleItemChange(CreditCardNetwork cardNetwork) {
    setState(() => _cardNetwork = cardNetwork);
  }

  @override
  void onItemChange(String name, String value) => values[name] = value;
}
