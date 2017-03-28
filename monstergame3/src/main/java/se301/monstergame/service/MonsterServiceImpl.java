package se301.monstergame.service;

import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.mongodb.DBAddress;
import com.mongodb.MongoClient;

import se301.monstergame.model.Monster;

@Service("monsterService")
public class MonsterServiceImpl implements MonsterService {

	private static MongoOperations MongoOperations;

	static {
		try {
			String address = "127.0.0.1:27017";
			String dbname = "monsterdbs";
			MongoOperations = new MongoTemplate(new MongoClient(new DBAddress(address)), dbname);
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}

	private static List<Monster> monsters;

	static {
		monsters = populateDummyMonsters();
	}

	public List<Monster> findAllMonsters() {
		return MongoOperations.findAll(Monster.class);
	}

	public Monster findById(long id) {
		BasicQuery query = new BasicQuery("{ id : " + id + " }");
		return MongoOperations.findOne(query, Monster.class);
	}

	public Monster findByName(String name) {
		BasicQuery query = new BasicQuery("{ username : \"" + name + "\" }");
		return MongoOperations.findOne(query, Monster.class);
	}

	public void saveMonster(Monster monster) {
		monster.setId(getNextId());
		MongoOperations.insert(monster);
	}

	public void updateMonster(Monster monster) {
		MongoOperations.save(monster);
	}

	public void deleteMonsterById(long id) {
		BasicQuery query = new BasicQuery("{ id : " + id + " }");
		MongoOperations.remove(query, Monster.class);
	}

	public boolean doesMonsterExist(Monster monster) {
		return findByName(monster.getMonstername()) != null;
	}

	public void deleteAllMonsters() {
		MongoOperations.dropCollection(Monster.class);
	}

	private static List<Monster> populateDummyMonsters() {
		List<Monster> monsters = new ArrayList<Monster>();
		return monsters;
	}

	public long getNextId() {
		Query query = new Query();
		query.with(new Sort(Sort.Direction.DESC, "_id"));
		query.limit(1);
		Monster maxIdMonster = MongoOperations.findOne(query, Monster.class);
		if (maxIdMonster == null) {
			return 0;
		} else {
			long nextId = maxIdMonster.getId() + 1;
			return nextId;
		}
	}

}