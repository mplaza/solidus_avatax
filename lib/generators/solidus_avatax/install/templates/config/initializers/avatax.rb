# Avatax Setup
SpreeAvatax::Config.username = 'your avatax username'
SpreeAvatax::Config.password = 'your avatax password'
SpreeAvatax::Config.company_code = 'your avatax company code'
if Rails.env.production?
  SpreeAvatax::Config.service_url = "https://avatax.avalara.net"
else
  SpreeAvatax::Config.service_url = "https://development.avalara.net"
end

# Use Avatax to compute return invoice tax amounts
Spree::Reimbursement.reimbursement_tax_calculator = lambda do |reimbursement|
  SpreeAvatax::ReturnInvoice.generate(reimbursement)
end
# Finalize the avatax return invoice after a reimubursement completes successfully
Spree::Reimbursement.reimbursement_success_hooks << lambda do |reimbursement|
  SpreeAvatax::ReturnInvoice.finalize(reimbursement)
end