namespace rb Accounts.V1

struct EmailAddress {
   1:i64 id
   2:string email
}

struct User {
    1:i64 id
    2:required list<EmailAddress> emails
}

struct Account {
    1:i64 id
    3:list<User> users
}

service AccountsService {
  void create(1:Account account)
  void set_account_attribute(1:i64 attribute_value)
  oneway void update(1:Account account)
}
