#! /bin/bash
#Cloud Storage Lab
#Initializing Configuration
gcloud init < a

cookie='_ga=GA1.2.138603024.1606913934; variant_determinant=977; __zlcmid=11Sjd3qnsQYUTDd; _gid=GA1.2.1729571221.1607585941; ajs_user_id=%22run-77d3bb4a61ea0be45d7bf1417d59fb1a%22; ajs_anonymous_id=%220205f4ca-a2a0-4bb0-8700-67a8e7983f28%22; _gat=1; _cvl-4_1_14_session=cGpQaTByR1Ftb1JWZVowUUE3cUNCdjVVd3RJRnk2VzZZOEJrc0d5Q3ArWjF0YS8zUWFPTzdRMS9UNWJjYkp4QWtDN29iV1gwb2lTL0xQcThDSC94eGQ5S2FyT0FPM01pb0IzenRMdm5qM3g4NU1VQkM3aWlDMGNlMjMzcHhwWnFTdUpnRS8wcXo5R0ZIQ0RFQVB2TW5oZjkvenltT2xma0JKZjZYQmpuN3ZBeG9Ua1lVd25FeHFMQmJjejgwaTRHcjUycmNSaHRlb3VNQVgyY1p0eGNocmRQUEljY1MxTTJXbmIxT2Nhc2xTQ3BzUUlQNkppRDNZWXBqanAzL3lodzhCT1JHbngvZWtVMVV1bUcyM2lGMHRCYThPUERidUhTOEFzRC9qZ3RzNmNZLytPK2FSMFhTbUtRUGhFdGlwcGF6ZEVxdWwxUFJLUEM0aThXMDBmNGhKNUNyaU1iOXBBM2dlVjl2dXBXV2JSeW5rOWdJUGRnaHJrNWRTYnUvWGpoNExEZUhHYVlxQW5FUzd3WXNPVnlyVHJCdU0veWtJRkJ4THRFQjlyTEcxd25vRmUwRVh1d1pvQVp1ZEhSbU5qQi0tRmlWOERqSnZYajFRSERGZHFsc1dLUT09--d8bac7b52f0739b9e91412ea37b395a40cf437f6'
ID=$(gcloud info --format='value(config.project)')
id=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/focuses/show_spl/6485.json?parent=game" | jq -r '.labInstanceId')
echo $id

# Create a GCS Bucket
if  gsutil mb gs://$ID
then
  result1=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/assessments/run_step.json?id=$id&step=1")

  # Copy an object to a folder in the bucket (ada.jpg)
  if  gsutil cp ./ada.jpg gs://$ID/
  then
    result2=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/assessments/run_step.json?id=$id&step=2")

    # Make your object publicly accessible
    if  gsutil acl ch -u AllUsers:R gs://$ID/ada.jpg
    then
      result3=$(curl -X GET --header "cookie: $cookie" "https://www.qwiklabs.com/assessments/run_step.json?id=$id&step=3")

      quiz1=$(curl -X POST --header "cookie: $cookie" --data "{"stem":"Every bucket must have a unique name across the entire Cloud Storage namespace.","is_correct":true,"response":"{\"value\":true}","item_type":"true-false"}" "https://www.qwiklabs.com/lab_instances/$id/probe_responses")
      quiz2=$(curl -X POST --header "cookie: $cookie" --data "{"stem":"Cloud Storage offers which storage classes:","is_correct":true,"response":"[{\"id\":\"2\",\"title\":\"Coldline\"},{\"id\":\"0\",\"title\":\"Standard\"},{\"id\":\"3\",\"title\":\"Archive\"},{\"id\":\"1\",\"title\":\"Nearline\"}]","item_type":"multiple-select"}" "https://www.qwiklabs.com/lab_instances/$id/probe_responses")
      quiz3=$(curl -X POST --header "cookie: $cookie" --data "{"stem":"Object names must be unique only within a given bucket.","is_correct":true,"response":"{\"value\":true}","item_type":"true-false"}" "https://www.qwiklabs.com/lab_instances/$id/probe_responses")
      
      printf "\n\e[1;92m%s\n\n\e[m" 'Lab Completed'
    fi
  fi
fi
gcloud auth revoke --all
