#
# !!!! Don't include this recipe !!!!
#      It is used only in tests
#

initialize_lifecycle([:online, :offline, :destroy])

lifecycle 'ntpd' do
  online(action: 'start',
         notify: 'reload')
  offline(action: 'stop',
          notify: 'nothing')
  destroy(action: 'stop',
          notify: 'nothing')
end

service 'ntpd' do
  action action_for('ntpd')
end
