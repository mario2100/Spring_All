package course

import org.apache.spark.{SparkConf, SparkContext}

object InitializingSpark {

  def main(args: Array[String]): Unit = {
    val appName = " "
    val master = ""
    val conf = new SparkConf().setAppName(appName).setMaster(master)
    val sc = new SparkContext(conf)
    //Parallelized Collections
    val data = Array(1, 2, 3, 4, 5)
    val distData = sc.parallelize(data)

  }


}
