import '../../models/team.dart';
import '../api_client.dart';

class TeamRepository {
  final ApiClient _apiClient;

  TeamRepository(this._apiClient);

  Future<List<Team>> getAllTeams() async {
    return _apiClient.getList('/api/teams', (json) => Team.fromJson(json));
  }

  Future<Team> getTeamById(int id) async {
    return _apiClient.get('/api/teams/$id', (json) => Team.fromJson(json));
  }

  Future<Team> createTeam(Team team) async {
    return _apiClient.post('/api/teams', team.toJson(), (json) => Team.fromJson(json));
  }

  Future<Team> updateTeam(Team team) async {
    return _apiClient.put('/api/teams', team.id!, team.toJson(), (json) => Team.fromJson(json));
  }

  Future<void> deleteTeam(int id) async {
    return _apiClient.delete('/api/teams', id);
  }
}
