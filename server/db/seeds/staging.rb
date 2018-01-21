u = User.new(first_name: 'root',
             last_name: 'root',
             email: 'root@root.com',
             password: 'toor',
             root: true
)
u.skip_confirmation!
u.skip_confirmation_notification!
u.save(:validate => false)