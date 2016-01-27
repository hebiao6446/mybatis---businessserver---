package com.business.service;

import java.util.HashMap;
import java.util.List;
import com.business.entity.Contacts;
import com.business.entity.ContactsGroupUser;
import com.business.entity.Group;
import com.business.entity.Role;
import com.business.entity.User;

public interface ContactsManager {

	List<Group> findGroupList(HashMap<String, Object> param);

	Object findGroupListCount(HashMap<String, Object> param);

	void updateGroupInfo(HashMap param);

	List<ContactsGroupUser> findGroupContactsList(HashMap<String, Object> param);

	Object findGroupContactsListCount(HashMap<String, Object> param);

	void updateContactsInfo(HashMap param);

	Contacts findContactsInfoByField(HashMap param);

	List<HashMap> findMySubContactsList(HashMap param);

	Integer updateUserInfo(HashMap<String, Object> param);

	User findUsersInfoByField(HashMap<String, Object> param);

	List<Role> findRoleList(HashMap<String, Object> param);

	Object findMySubContactsListCount(HashMap<String, Object> param);
	

	

}
