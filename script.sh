#! /bin/bash
#Cloud Storage Lab
#Initializing Configuration
gcloud init < a

cookie='replace with ur cookie'
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
