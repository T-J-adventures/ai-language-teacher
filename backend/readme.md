Jogosultság: 
    Az aws-ben kell kikeresni és környezeti változóba beletenni a szükséges kulcsokat.
    Egy példa:
        export AWS_ACCESS_KEY_ID="ASIAT7O5O67VPLUVMJQA"
        export AWS_SECRET_ACCESS_KEY="qfIimlRWW5w9Wo6+9OOZJSo4vEQmkh/3fq5aWoWo"
        export AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjECkaCXVzLWVhc3QtMSJHMEUCIG9hlC0suF7DCeQrZG6M1cVQ+2EYFWnY9VU4aSD+0UnMAiEApg78SvJ6+qFlXTHTWn3fMrDeIs/m2X5/oYZKJRTjdWUq7AIIkv//////////ARAAGgwyNzM3MzE3NDU3NzAiDFBn1ZoDREjkoTlgIirAAs9CroqTrNhtmQcfpEv6iqaT1Bw8bu/sb5v7kI++SzDKVVIX/v2TC+ug/5CzaCe0ILmCZRI+upiftAW6vw0xQCiOhY/EtqYfj0G7OkbTkDV0QhZ+nA3mfczO0hoeh1EoS0jpkjxqCxk5xe9/RL6LqmW8Kfc2gOtJxh07HQZgPiZU9k3VrYklh8VwCbkl9NWU9Yhbb+LQikkh/wB5QEH1E10TGFyhRhb2BYSXbtOMHvXTzqeZzJb5Su3+qJhmKXZqan1p5v9ITFRoCaT2uGXDwY9YD42Ge1eWt6WLMkdbfWQ6uxofhAN5TODpjeEcxyJTdsh2NdZKoJe7eQEDs9JN6uuiJgHciCcFhobirSri0ITidTxq/gFdw37UmkC2lPWal9NPLeuyXJmrrLGwHipJWpah9d57/Sq/SBwUCIhe6EudMOvRwqsGOqcBDt+hpI1Ge8C+WMdofUvG85jQQiYF8qKhG6JHbswd4BEbvOuok4KlqVxmjxtXiNApTvTIUMqAQZez8DGnBahtPqFSck0LLtLsNOIplBTwCNXH5XA7wEA1g1u3g3K+GYTnXQkUZcWaizcP33/vDzdZAtt/dc84uHPufLhCncBUbr26d0dzffv6rVn0Cukz7l2qHEVBrgpBA4tQl6osC/SCMj9a0I5Op/Q="

terraform init
terraform plan
terraform apply
terraform destroy

curl https://w0j9appfq1.execute-api.eu-central-1.amazonaws.com/test/hello -X POST -d '{"name": "Joe"}'
