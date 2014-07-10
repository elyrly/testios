require 'fileutils'

require 'sinatra'

require 'aws-sdk'

require 'aws/ses'


Parse.init :application_id => "h8IkXf9ZVxSb1XYhFeaMbFsNbbSsQKRYnHSDAx98",
           :api_key        => "23dDwtnn6xxxh0gHpCFImNcYTjoshPoTKGEvqIV4"

ses = AWS::SimpleEmailService.new access_key_id: 'AKIAIZLKLWQJVZXUGQFQ',
                                  secret_access_key: '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'

print ses.identities.to_a

get '/upload/:transaction_id/:party' do
    @transaction_id, @party = params[:transaction_id], params[:party]

    erb :upload
end

post '/upload/:transaction_id/:party' do
    #params[:transaction_id], params[:party], params['doc_type'], params['document_file'][:tempfile].read
    
    dir = "public/#{params[:transaction_id]}/#{params[:party]}"
    document_file_name = "#{dir}/#{params['document_type']}.pdf"

    FileUtils.mkdir_p dir
    FileUtils.mv params['document_file'][:tempfile].path, document_file_name

    ses.send_email(
        to: 'joshuapferguson@yahoo.com',
        from: 'joshuapferguson@yahoo.com', #we don't have a domain name yet so anti-spam filters may not like this
        subject: "#{params['document_type']} submitted for transaction n°#{params[:transaction_id]}",
        body_text: 'check it out at blahblah'
    )

    @transaction_id, @party = params[:transaction_id], params[:party]
    @preview_file = document_file_name[6..-1] #remove /public... too lazy to find a cleaner way
    erb :upload
end


=begin
def document_file_path(transaction_id, party, type)
    "public/#{transaction_id}/#{party}/#{type}.pdf"
end
get '/document/:transaction_id/:party/:type.pdf' do
    send_file ['document', params[:transaction_id]].join('/')
end
=end
