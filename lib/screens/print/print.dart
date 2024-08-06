import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_machine/helpers/amount_helper.dart';
import 'package:pos_machine/models/list_cart.dart';

class PrintPage extends StatefulWidget {
  final List<dynamic> cartItems;
  final String formattedTotal;
  final String orderDate;
  final String orderNumber;
  const PrintPage({
    Key? key,
    required this.cartItems,
    required this.formattedTotal,
    required this.orderDate,
    required this.orderNumber,
  }) : super(key: key);

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  var printerManager = PrinterManager.instance;
  var devices = <BluetoothPrinter>[];
  StreamSubscription<PrinterDevice>? _subscription;
  BluetoothPrinter? selectedPrinter;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    if (await _requestPermissions()) {
      _scan();
    } else {
      _showPermissionDeniedDialog();
    }
  }

  Future<bool> _requestPermissions() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();

      return statuses.values.every((status) => status.isGranted);
    }
    return true; // For iOS, permissions are handled in Info.plist
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permissions Required'),
        content: const Text(
            'This app needs Bluetooth and Location permissions to scan for printers.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }

  void _scan() async {
    if (_isScanning) return;
    setState(() {
      _isScanning = true;
      devices.clear();
    });

    try {
      _subscription = printerManager
          .discovery(type: PrinterType.bluetooth, isBle: false)
          .listen((device) {
        final printer = BluetoothPrinter(
          deviceName: device.name,
          address: device.address,
          typePrinter: PrinterType.bluetooth,
        );
        setState(() {
          devices.add(printer);
        });
      });

      // Scan for USB printers
      await printerManager.discovery(type: PrinterType.usb).forEach((device) {
        final printer = BluetoothPrinter(
          deviceName: device.name,
          address: device.address,
          vendorId: device.vendorId,
          productId: device.productId,
          typePrinter: PrinterType.usb,
        );
        setState(() {
          devices.add(printer);
        });
      });
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  void selectPrinter(BluetoothPrinter printer) {
    setState(() {
      selectedPrinter = printer;
    });
  }

  Future<void> printReceipt() async {
    if (selectedPrinter == null) return;

    try {
      // Connect to the printer
      await printerManager.connect(
        type: selectedPrinter!.typePrinter,
        model: selectedPrinter!.typePrinter == PrinterType.bluetooth
            ? BluetoothPrinterInput(
                name: selectedPrinter!.deviceName!,
                address: selectedPrinter!.address!,
                isBle: false,
              )
            : TcpPrinterInput(ipAddress: selectedPrinter!.address!),
      );

      // Generate receipt
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      List<int> bytes = [];

      bytes += generator.text('Epos Invoice',
          styles: const PosStyles(
              align: PosAlign.center, bold: true, height: PosTextSize.size2));
      bytes += generator.text('Thank you for your purchase!');
      bytes += generator.feed(1);
      bytes += generator.text('Date: ${widget.orderDate.toString()}');
      bytes += generator.text('Order No: ${widget.orderNumber}');
      bytes += generator.feed(1);
      bytes += generator.hr();

      // Add order items header
      bytes += generator.row([
        PosColumn(text: 'Item', width: 6),
        PosColumn(text: 'Qty', width: 2),
        PosColumn(
            text: 'Price',
            width: 4,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
      bytes += generator.hr();

      // Add cart items
      for (var item in widget.cartItems) {
        bytes += generator.row([
          PosColumn(text: item.productName ?? '', width: 6),
          PosColumn(text: item.quantity.toString(), width: 2),
          PosColumn(
              text: AmountHelper.formatAmount(item.totalPrice ?? 0),
              width: 4,
              styles: const PosStyles(align: PosAlign.right)),
        ]);
      }

      bytes += generator.hr();

      // Add total
      bytes += generator.row([
        PosColumn(
            text: 'Total:', width: 8, styles: const PosStyles(bold: true)),
        PosColumn(
            text: widget.formattedTotal,
            width: 4,
            styles: const PosStyles(bold: true, align: PosAlign.right)),
      ]);

      bytes += generator.feed(2);
      bytes += generator.cut();

      // Print receipt
      await printerManager.send(
          type: selectedPrinter!.typePrinter, bytes: bytes);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Print job sent successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      // Disconnect from the printer
      await printerManager.disconnect(type: selectedPrinter!.typePrinter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index].deviceName ?? 'Unknown device'),
                  subtitle: Text(devices[index].address ?? ''),
                  trailing: ElevatedButton(
                    onPressed: () => selectPrinter(devices[index]),
                    child: Text(selectedPrinter == devices[index]
                        ? 'Selected'
                        : 'Select'),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedPrinter == null
                ? null
                : () {
                    printReceipt;
                  },
            child: const Text('Print Receipt'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isScanning ? null : _checkPermissions,
        child: _isScanning
            ? const CircularProgressIndicator()
            : const Icon(Icons.refresh),
        tooltip: 'Scan for printers',
      ),
    );
  }
}

class BluetoothPrinter {
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  PrinterType typePrinter;

  BluetoothPrinter({
    this.deviceName,
    this.address,
    this.port,
    this.vendorId,
    this.productId,
    this.typePrinter = PrinterType.bluetooth,
  });
}
