#Although our code contains many lines, it consists of two parts: Creating graphs for the chi-square method
#(defined by simpleDag), testing them using localTests function, and one part creating graphs for the Hotelling's
# method and testing them
library(dagitty)
library(bayesianNetworks)
library(ranger)

setwd('path to data')

data_dis <- read.csv('discretized_dataset.csv')
data_mix <- read.csv('no_missingvalues_dataset.csv')

#Define all our graphs below
simpleDag <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
}
')

simpleDag_2 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.686,0.062"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  fbs -> chol
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_3 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.686,0.062"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  fbs -> chol
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_4 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.686,0.062"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  fbs -> chol
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_5 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.686,0.062"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  fbs -> chol
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_6 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  exang -> thalach [pos="-1.763,0.454"]
  fbs -> chol
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_7 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
  fbs -> chol
}')

simpleDag_7_op <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
  fbs -> chol
  oldpeak -> slope
}')

simpleDag_8 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_9 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_10 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> restecg
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_11 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_12 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  thal -> ca
  thal -> thalach
  thal -> trestbps
  trestbps -> hd
}')

simpleDag_13 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  chol -> trestbps
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_14 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> restecg
  sex -> thal
  sex -> trestbps
  slope -> restecg
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_15 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> restecg
  sex -> thal
  slope -> restecg
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_16 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> restecg
  sex -> thal
  slope -> restecg
  thal -> ca
  thal -> thalach
}')

simpleDag_17 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> slope
  sex -> chol
  sex -> restecg
  sex -> thal
  slope -> restecg
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_18 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  slope -> restecg
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_19 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_20 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> restecg
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
}')

#Final network after testing
simpleDag_21 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_21_hd_ca <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  hd -> ca
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
  oldpeak -> slope
}')

simpleDag_22_hd <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  hd -> ca
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
  oldpeak -> slope
  thal -> hd
}')

simpleDag_23_hd <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  hd -> ca
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> thalach
  trestbps -> hd
  oldpeak -> slope
  thal -> hd
}')

simpleDag_24_hdca <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> thalach
  trestbps -> hd
  oldpeak -> slope
  thal -> hd
}')

simpleDag_25_ageca <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> ca
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> thalach
  trestbps -> hd
  oldpeak -> slope
  thal -> hd
  age -> ca
}')

simpleDag_26_agehd <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> ca
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> thalach
  trestbps -> hd
  oldpeak -> slope
  thal -> hd
  age -> ca
  age -> hd
}')

simpleDag_42 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  oldpeak -> slope
}')

simpleDag_43 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  hd -> ca
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  oldpeak -> slope
}')

simpleDag_41 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
}')

simpleDag_40 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_39 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_38 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_37 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_36 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_35 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')


simpleDag_34 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_22 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_23 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

#Start testing for edge strengths
simpleDag_24 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_25 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_26 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_27 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_28 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_29 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')

simpleDag_30 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> thal
  thal -> ca
  trestbps -> hd
}')

simpleDag_31 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> thalach
  trestbps -> hd
}')

simpleDag_32 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
}')

simpleDag_33 <- dagitty('dag {
  age [pos="-1.498,-1.380"]
  ca [pos="-1.646,0.182"]
  chol [pos="-0.620,-0.799"]
  cp [pos="-1.053,1.290"]
  exang [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  hd [pos="-0.697,0.635"]
  oldpeak [pos="0.281,1.326"]
  restecg [pos="0.123,0.378"]
  sex [pos="0.030,-1.415"]
  slope [pos="-0.408,1.317"]
  thal [pos="-1.307,-0.423"]
  thalach [pos="-1.685,-0.758"]
  trestbps [pos="-0.896,-0.233"]
  age -> ca
  age -> fbs
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  ca -> hd
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  sex -> chol
  sex -> thal
  thal -> ca
  thal -> thalach
  trestbps -> hd
}')


l_prune1 <- localTests(simpleDag, data_dis, type="cis.chisq")
l_prune2 <- localTests(simpleDag_2, data_dis, type="cis.chisq")
l_prune3 <- localTests(simpleDag_3, data_dis, type="cis.chisq")
l_prune4 <- localTests(simpleDag_4, data_dis, type="cis.chisq")
l_prune5 <- localTests(simpleDag_5, data_dis, type="cis.chisq")
l_prune6 <- localTests(simpleDag_6, data_dis, type="cis.chisq") 
l_prune7 <- localTests(simpleDag_7, data_dis, type="cis.chisq")
l_prune8 <- localTests(simpleDag_8, data_dis, type="cis.chisq")
l_prune9 <- localTests(simpleDag_9, data_dis, type="cis.chisq")
l_prune10 <- localTests(simpleDag_10, data_dis, type="cis.chisq")
l_prune11 <- localTests(simpleDag_11, data_dis, type="cis.chisq")
l_prune12 <- localTests(simpleDag_12, data_dis, type="cis.chisq")
l_prune13 <- localTests(simpleDag_13, data_dis, type="cis.chisq")
l_prune14 <- localTests(simpleDag_14, data_dis, type="cis.chisq")
l_prune15 <- localTests(simpleDag_15, data_dis, type="cis.chisq")
l_prune16 <- localTests(simpleDag_16, data_dis, type="cis.chisq")
l_prune17 <- localTests(simpleDag_17, data_dis, type="cis.chisq")
l_prune18 <- localTests(simpleDag_18, data_dis, type="cis.chisq")
l_prune19 <- localTests(simpleDag_19, data_dis, type="cis.chisq")
l_prune20 <- localTests(simpleDag_20, data_dis, type="cis.chisq")
l_prune21 <- localTests(simpleDag_21, data_dis, type="cis.chisq")
l_prune22 <- localTests(simpleDag_22, data_dis, type="cis.chisq")
l_prune23 <- localTests(simpleDag_23, data_dis, type="cis.chisq")
l_prune24 <- localTests(simpleDag_24, data_dis, type="cis.chisq")
l_prune25 <- localTests(simpleDag_25, data_dis, type="cis.chisq")
l_prune26 <- localTests(simpleDag_26, data_dis, type="cis.chisq")
l_prune27 <- localTests(simpleDag_27, data_dis, type="cis.chisq")
l_prune28 <- localTests(simpleDag_28, data_dis, type="cis.chisq")
l_prune29 <- localTests(simpleDag_29, data_dis, type="cis.chisq")
l_prune30 <- localTests(simpleDag_30, data_dis, type="cis.chisq")
l_prune31 <- localTests(simpleDag_31, data_dis, type="cis.chisq")
l_prune32 <- localTests(simpleDag_32, data_dis, type="cis.chisq")
l_prune33 <- localTests(simpleDag_33, data_dis, type="cis.chisq")
l_prune34 <- localTests(simpleDag_34, data_dis, type="cis.chisq")
l_prune35 <- localTests(simpleDag_35, data_dis, type="cis.chisq")
l_prune36 <- localTests(simpleDag_36, data_dis, type="cis.chisq")
l_prune37 <- localTests(simpleDag_37, data_dis, type="cis.chisq")
l_prune38 <- localTests(simpleDag_38, data_dis, type="cis.chisq")
l_prune39 <- localTests(simpleDag_39, data_dis, type="cis.chisq")
l_prune40 <- localTests(simpleDag_40, data_dis, type="cis.chisq")
l_prune41 <- localTests(simpleDag_41, data_dis, type="cis.chisq")
l_prune42 <- localTests(simpleDag_42, data_dis, type="cis.chisq")

#Find out difference in implied independencies, to see whether the i
l_prune9[setdiff(rownames(l_prune9), rownames(l_prune8)), ]
l_prune10[setdiff(rownames(l_prune10), rownames(l_prune8)), ]
l_prune11[setdiff(rownames(l_prune11), rownames(l_prune8)), ]
l_prune12[setdiff(rownames(l_prune12), rownames(l_prune11)), ]
l_prune13[setdiff(rownames(l_prune13), rownames(l_prune11)), ]
l_prune14[setdiff(rownames(l_prune14), rownames(l_prune13)), ]
l_prune15[setdiff(rownames(l_prune15), rownames(l_prune14)), ]
l_prune16[setdiff(rownames(l_prune16), rownames(l_prune15)), ]
l_prune17[setdiff(rownames(l_prune17), rownames(l_prune15)), ]
l_prune16[setdiff(rownames(l_prune16), rownames(l_prune15)), ]
l_prune18[setdiff(rownames(l_prune18), rownames(l_prune15)), ]
l_prune19[setdiff(rownames(l_prune19), rownames(l_prune18)), ]
l_prune20[setdiff(rownames(l_prune20), rownames(l_prune19)), ]
l_prune21[setdiff(rownames(l_prune21), rownames(l_prune19)), ]
l_prune22[setdiff(rownames(l_prune22), rownames(l_prune21)), ]
l_prune23[setdiff(rownames(l_prune23), rownames(l_prune21)), ]
l_prune24[setdiff(rownames(l_prune24), rownames(l_prune21)), ]
l_prune25[setdiff(rownames(l_prune25), rownames(l_prune21)), ]
l_prune26[setdiff(rownames(l_prune26), rownames(l_prune21)), ]
l_prune27[setdiff(rownames(l_prune27), rownames(l_prune21)), ]
l_prune28[setdiff(rownames(l_prune28), rownames(l_prune21)), ]
l_prune29[setdiff(rownames(l_prune29), rownames(l_prune21)), ]
l_prune30[setdiff(rownames(l_prune30), rownames(l_prune21)), ]
l_prune31[setdiff(rownames(l_prune31), rownames(l_prune21)), ]
l_prune32[setdiff(rownames(l_prune32), rownames(l_prune21)), ]
l_prune33[setdiff(rownames(l_prune33), rownames(l_prune21)), ]
l_prune34[setdiff(rownames(l_prune34), rownames(l_prune21)), ]
l_prune35[setdiff(rownames(l_prune35), rownames(l_prune21)), ]
l_prune36[setdiff(rownames(l_prune36), rownames(l_prune21)), ]
l_prune37[setdiff(rownames(l_prune37), rownames(l_prune21)), ]
l_prune38[setdiff(rownames(l_prune38), rownames(l_prune21)), ]
l_prune39[setdiff(rownames(l_prune39), rownames(l_prune21)), ]
l_prune40[setdiff(rownames(l_prune40), rownames(l_prune21)), ]
l_prune41[setdiff(rownames(l_prune41), rownames(l_prune42)), ]

#Define graphs for experimental below
expDag_1 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
}
')

expDag_2 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
}
')

expDag_3 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
}
')

expDag_4 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
}
')

expDag_5 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
}
')

expDag_6 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
}
')

expDag_7 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
}
')

expDag_8 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
}
')

expDag_9 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
}
')

expDag_10 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
}
')

expDag_11 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
}
')

expDag_12 <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
}
')

#expDag_xx_op graphs have the edge from oldpeak to slope added, we added it later because it did not make much sense theoretically
expDag_12_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
oldpeak -> restecg
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
slope -> thalach
ca -> slope
}
')

expDag_13_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
fbs -> chol
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_14_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
trestbps -> hd
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_15_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
sex -> restecg
sex -> trestbps
slope -> restecg
thal -> trestbps
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_16_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> restecg
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
sex -> trestbps
slope -> restecg
thal -> trestbps
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_17_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
sex -> trestbps
slope -> restecg
thal -> trestbps
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_18_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
chol -> trestbps
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
sex -> trestbps
slope -> restecg
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_19_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
sex -> trestbps
slope -> restecg
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_20_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
slope -> restecg
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_21_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
thal -> restecg
oldpeak -> slope
}
')

expDag_22_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> restecg
hd -> slope
sex -> chol
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
oldpeak -> slope
}
')

expDag_23_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
chol -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> slope
sex -> chol
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
oldpeak -> slope
}
')

expDag_24_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> slope
sex -> chol
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
sex -> hd
age -> oldpeak
oldpeak -> slope
}
')

expDag_25_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> slope
sex -> chol
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
age -> oldpeak
oldpeak -> slope
}
')

expDag_26_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
ca -> hd
hd -> cp
hd -> exang
hd -> oldpeak
hd -> slope
sex -> chol
age -> ca
thal -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
age -> oldpeak
oldpeak -> slope
slope -> thalach
ca -> slope
}
')

expDag_27_op <- dagitty('dag {
age [pos="-1.498,-1.380"]
ca [pos="-1.686,0.062"]
chol [pos="-0.620,-0.799"]
cp [pos="-1.053,1.290"]
exang [pos="-1.686,1.303"]
fbs [pos="-0.610,-1.310"]
hd [pos="-0.697,0.635"]
oldpeak [pos="0.281,1.326"]
restecg [pos="0.123,0.378"]
sex [pos="0.539,-1.315"]
slope [pos="-0.408,1.317"]
thal [pos="-1.307,-0.423"]
thalach [pos="-1.685,-0.758"]
trestbps [pos="-0.896,-0.233"]
age -> fbs
age -> thalach [pos="-1.612,-1.148"]
age -> trestbps
hd -> ca
hd -> cp
hd -> exang
hd -> oldpeak
hd -> slope
sex -> chol
age -> ca
cp -> exang
exang -> thalach
thal -> hd
hd -> thalach
sex -> thal
chol -> restecg
age -> chol
age -> oldpeak
oldpeak -> slope
slope -> thalach
ca -> slope
age -> hd
}
')

#The loop below was used for adding edges.
#We looped over all the conditional independencies, and test each one of them using the Hotelling's test
for (cii in impliedConditionalIndependencies(expDag_27_op)) {
  tst <- bayesianNetworks::ci.test(cii$X, cii$Y, cii$Z, data=data_mix)
  if(tst$p.value < 0.01) {
    print(paste(cii$X, '->', cii$Y, '_||_', cii$Z, tst$statistic, tst$effect, tst$p.value) )
  }
}

#Use residualization on Hotelling's method, we used this code to test for pruning of edges
for( x in names(expDag_27_op) ){
  px <- parents(expDag_27_op,x )
  for( y in px ){
    tst <- bayesianNetworks::ci.test( x, y, setdiff(px,y), data=data_mix )
    print( paste(y,'->',x, tst$effect, tst$p.value ) )
  }
}

