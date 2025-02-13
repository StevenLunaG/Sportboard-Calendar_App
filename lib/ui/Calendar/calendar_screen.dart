import 'package:flutter/material.dart';
                import 'package:table_calendar/table_calendar.dart';
                import 'package:provider/provider.dart';
                import '../../models/match.dart';
                import '../../providers/calendar_provider.dart';

                class CalendarScreen extends StatefulWidget {
                  @override
                  _CalendarScreenState createState() => _CalendarScreenState();
                }

                class _CalendarScreenState extends State<CalendarScreen> {
                  DateTime _focusedDay = DateTime.now();
                  DateTime? _selectedDay;

                  @override
                  void initState() {
                    super.initState();
                    Provider.of<CalendarProvider>(context, listen: false).loadMatches();
                  }

                  @override
                  Widget build(BuildContext context) {
                    return Consumer<CalendarProvider>(
                      builder: (context, calendarProvider, child) {
                        return Scaffold(
                          body: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TableCalendar(
                                  firstDay: DateTime(2020),
                                  lastDay: DateTime(2030),
                                  focusedDay: _focusedDay,
                                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                      _focusedDay = focusedDay;
                                    });
                                  },
                                  calendarStyle: CalendarStyle(
                                    selectedDecoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      shape: BoxShape.circle,
                                    ),
                                    todayDecoration: BoxDecoration(
                                      color: Colors.black38,
                                      shape: BoxShape.circle,
                                    ),
                                    weekendTextStyle: TextStyle(color: Colors.deepPurpleAccent),
                                    markerDecoration: BoxDecoration(
                                      color: Colors.purpleAccent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  headerStyle: HeaderStyle(
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                  ),
                                  eventLoader: (day) {
                                    return calendarProvider.hasMatches(day) ? [1] : [];
                                  },
                                ),
                                const SizedBox(height: 20),
                                if (_selectedDay != null)
                                  Expanded(
                                    child: Builder(
                                      builder: (context) {
                                        List<Match> matches = calendarProvider.getMatchesByDate(_selectedDay!);
                                        return matches.isNotEmpty
                                            ? ListView.builder(
                                          itemCount: matches.length,
                                          itemBuilder: (context, index) {
                                            final match = matches[index];
                                            return Card(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 4.0,
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  "${match.homeTeam?.name ?? 'Local'} vs ${match.guestTeam?.name ?? 'Visitante'}",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Fecha: ${match.formattedDate}"),
                                                    Text("Hora: ${match.formattedStartTime}"),
                                                    Text("Estado: ${match.status.toString().split('.').last}"),
                                                  ],
                                                ),

                                              ),
                                            );
                                          },
                                        )
                                            : Center(
                                          child: Text(
                                            "No hay partidos programados",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }