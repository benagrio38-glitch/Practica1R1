import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:conociendo_persona/main.dart';

void main() {
  testWidgets('Verificar muestra el resultado y Limpiar lo borra',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Conociendo a la persona'), findsOneWidget);
    expect(find.text('Aquí aparecerá el resultado'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Ana López');
    await tester.enterText(find.byType(TextField).at(1), '20');
    await tester.enterText(find.byType(TextField).at(2), '10000');

    await tester.tap(find.text('Verificar'));
    await tester.pumpAndSettle();

    // El mensaje aparece en el diálogo y en la etiqueta.
    expect(find.textContaining('Eres mayor de edad.'), findsNWidgets(2));
    expect(find.textContaining('SÍ está por arriba'), findsNWidgets(2));

    await tester.tap(find.text('Aceptar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Limpiar datos'));
    await tester.pump();
    expect(find.text('Aquí aparecerá el resultado'), findsOneWidget);
  });

  testWidgets('Campos vacíos muestran aviso de datos incompletos',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Verificar'));
    await tester.pumpAndSettle();

    expect(find.text('Datos incompletos'), findsOneWidget);
  });
}
