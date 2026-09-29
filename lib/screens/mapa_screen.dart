import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class MapaScreen extends StatelessWidget {
  const MapaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final pontos = state.rota.map((p) => LatLng(p.latitude, p.longitude)).toList();
    final centro = pontos.isNotEmpty ? pontos.last : const LatLng(-30.0, -48.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Rota da campanha')),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(initialCenter: centro, initialZoom: 7),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'br.org.censoaves.prototype',
              ),
              if (pontos.length >= 2)
                PolylineLayer(polylines: [Polyline(points: pontos, strokeWidth: 4)]),
              if (pontos.isNotEmpty)
                MarkerLayer(markers: [
                  Marker(
                    point: pontos.last,
                    width: 50,
                    height: 50,
                    child: const Icon(Icons.directions_boat, size: 36),
                  ),
                ]),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FilledButton.icon(
              onPressed: state.iniciarRastreamento,
              icon: const Icon(Icons.my_location),
              label: Text(pontos.isEmpty ? 'ATIVAR GPS E INICIAR ROTA' : 'GPS ATIVO / ATUALIZAR'),
            ),
          ),
        ],
      ),
    );
  }
}
