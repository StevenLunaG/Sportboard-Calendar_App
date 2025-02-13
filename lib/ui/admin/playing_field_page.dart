import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/playing_field.dart';
import '../../models/address.dart';

class PlayingFieldPage extends StatefulWidget {
  @override
  _PlayingFieldPageState createState() => _PlayingFieldPageState();
}

class _PlayingFieldPageState extends State<PlayingFieldPage> {
  final String baseUrl = 'http://localhost:9000/api';
  List<PlayingField> _playingFields = [];
  List<Address> _addresses = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final playingFieldsResponse = await http.get(
        Uri.parse('$baseUrl/playing-fields'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final addressesResponse = await http.get(
        Uri.parse('$baseUrl/addresses'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (playingFieldsResponse.statusCode == 200 && addressesResponse.statusCode == 200) {
        final List<dynamic> playingFieldsData = json.decode(playingFieldsResponse.body);
        final List<dynamic> addressesData = json.decode(addressesResponse.body);

        setState(() {
          _playingFields = playingFieldsData.map((json) => PlayingField.fromJson(json)).toList();
          _addresses = addressesData.map((json) => Address.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Error: ${playingFieldsResponse.statusCode} / ${addressesResponse.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _createPlayingField(String name, Address address) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/playing_fields'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'name': name, 'address': address.toJson()}),
      );

      if (response.statusCode == 200) {
        _loadData();
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _createAddress(Address address) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/addresses'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(address.toJson()),
      );

      if (response.statusCode == 200) {
        _loadData();
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _deletePlayingField(int id) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/playing_fields/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _loadData();
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteAddress(int id) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/addresses/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _loadData();
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _editPlayingField(int id, String name, Address address) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/playing_fields/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'name': name, 'address': address.toJson()}),
      );

      if (response.statusCode == 200) {
        _loadData();
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _editAddress(int id, Address address) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/addresses/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(address.toJson()),
      );

      if (response.statusCode == 200) {
        _loadData();
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Campos de Juego', style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _playingFields.length,
                        itemBuilder: (context, index) {
                          final playingField = _playingFields[index];
                          return ListTile(
                            title: Text(playingField.name ?? 'No name'),
                            subtitle: Text(playingField.address?.principalStreet ?? 'No address'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _showEditPlayingFieldDialog(context, playingField),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await _deletePlayingField(playingField.id!);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Direcciones', style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _addresses.length,
                        itemBuilder: (context, index) {
                          final address = _addresses[index];
                          return ListTile(
                            title: Text(address.principalStreet ?? 'No principal street'),
                            subtitle: Text(address.secondaryStreet ?? 'No secondary street'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _showEditAddressDialog(context, address),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await _deleteAddress(address.id!);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _showAddPlayingFieldDialog(context),
            child: Icon(Icons.location_on),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _showAddAddressDialog(context),
            child: Icon(Icons.near_me),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddPlayingFieldDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final addressController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar Campo de Juego'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre del Campo'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final address = Address(principalStreet: addressController.text);
              await _createPlayingField(nameController.text, address);
              Navigator.pop(context);
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddAddressDialog(BuildContext context) async {
    final principalStreetController = TextEditingController();
    final secondaryStreetController = TextEditingController();
    final referenceController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar Dirección'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: principalStreetController,
              decoration: InputDecoration(labelText: 'Calle Principal'),
            ),
            TextField(
              controller: secondaryStreetController,
              decoration: InputDecoration(labelText: 'Calle Secundaria'),
            ),
            TextField(
              controller: referenceController,
              decoration: InputDecoration(labelText: 'Referencia'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final address = Address(
                principalStreet: principalStreetController.text,
                secondaryStreet: secondaryStreetController.text,
                reference: referenceController.text,
              );
              await _createAddress(address);
              Navigator.pop(context);
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditPlayingFieldDialog(BuildContext context, PlayingField playingField) async {
    final nameController = TextEditingController(text: playingField.name);
    final addressController = TextEditingController(text: playingField.address?.principalStreet);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Campo de Juego'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre del Campo'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final address = Address(principalStreet: addressController.text);
              await _editPlayingField(playingField.id!, nameController.text, address);
              Navigator.pop(context);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditAddressDialog(BuildContext context, Address address) async {
    final principalStreetController = TextEditingController(text: address.principalStreet);
    final secondaryStreetController = TextEditingController(text: address.secondaryStreet);
    final referenceController = TextEditingController(text: address.reference);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Dirección'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: principalStreetController,
              decoration: InputDecoration(labelText: 'Calle Principal'),
            ),
            TextField(
              controller: secondaryStreetController,
              decoration: InputDecoration(labelText: 'Calle Secundaria'),
            ),
            TextField(
              controller: referenceController,
              decoration: InputDecoration(labelText: 'Referencia'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final updatedAddress = Address(
                id: address.id,
                principalStreet: principalStreetController.text,
                secondaryStreet: secondaryStreetController.text,
                reference: referenceController.text,
              );
              await _editAddress(address.id!, updatedAddress);
              Navigator.pop(context);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}