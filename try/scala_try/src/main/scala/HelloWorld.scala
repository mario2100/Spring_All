import scala.collection.mutable.ArrayBuffer
import scala.util.Random
import scala.math._
import scala.util.matching.Regex

object HelloWorld {
  def main(args: Array[String]): Unit = {
    val it = new Try(10)
    println("Hello, world!")
    println(it.next())
    println(it.next())

    val dog = new Dog("Harry")
    val cat = new Cat("Sally")
    val animals = ArrayBuffer.empty[Pet]
    animals.append(dog)
    animals.append(cat)
    animals.foreach(pet => println(pet.name))
    println("--------------------------")
    val planets =
      List(("Mercury", 57.9), ("Venus", 108.2), ("Earth", 149.6),
        ("Mars", 227.9), ("Jupiter", 778.3))
    planets.foreach {
      case ("Earth", distance) =>
        println(s"Our planet is $distance million kilometers from the sun")
      case _ =>
    }
    println("--------------------------")
    val numPairs = List((2, 5), (3, -7), (20, 56))
    for ((a, b) <- numPairs) {
      println(a * b)
    }

    abstract class A {
      val message: String
    }

    class B extends A {
      val message = "I'm an instance of class B"
    }

    trait C extends A {
      def loudMessage = message.toUpperCase()
    }
    class D extends B with C

    val d = new D
    println(d.message) // I'm an instance of class B
    println(d.loudMessage)

    abstract class AbsIterator {
      type T

      def hasNext: Boolean

      def next(): T
    }

    class StringIterator(s: String) extends AbsIterator {
      type T = Char
      private var i = 0

      def hasNext = i < s.length

      def next() = {
        val ch = s charAt i
        i += 1
        ch
      }
    }

    trait RichIterator extends AbsIterator {
      def foreach(f: T => Unit): Unit = while (hasNext) f(next())
    }

    class RichStringIter extends StringIterator("Scala") with RichIterator
    val richStringIter = new RichStringIter
    richStringIter.foreach(println)

    val salaries = Seq(20000, 70000, 40000)
    val doubleSalary = (x: Int) => x * 2
    var newSalaries = salaries.map(doubleSalary)
    newSalaries = salaries.map(x => x * 2)
    newSalaries = salaries.map(_ * 2)

    case class WeeklyWeatherForecast(temperatures: Seq[Double]) {

      private def convertCtoF(temp: Double) = temp * 1.8 + 32

      def forecastInFahrenheit: Seq[Double] = temperatures.map(convertCtoF) // <-- passing the method convertCtoF
    }


    def promotion(salaries: List[Double], promotionFunction: Double => Double): List[Double] =
    salaries.map(promotionFunction)

    def smallPromotion(salaries: List[Double]): List[Double] =
      promotion(salaries, salary => salary * 1.1)

    def greatPromotion(salaries: List[Double]): List[Double] =
      promotion(salaries, salary => salary * math.log(salary))

    def hugePromotion(salaries: List[Double]): List[Double] =
      promotion(salaries, salary => salary * salary)

    def urlBuilder(ssl: Boolean, domainName: String): (String, String) => String = {
      val schema = if (ssl) "https://" else "http://"
      (endpoint: String, query: String) => s"$schema$domainName/$endpoint?$query"
    }

    val domainName = "www.example.com"
    def getURL = urlBuilder(ssl=true, domainName)
    val endpoint = "users"
    val query = "id=1"
    val url = getURL(endpoint, query)

    def factorial(x: Int): Int = {
      def fact(x: Int, accumulator: Int): Int = {
        if (x <= 1) accumulator
        else fact(x - 1, x * accumulator)
      }
      fact(x, 1)
    }

    println("Factorial of 2: " + factorial(2))
    println("Factorial of 3: " + factorial(3))


//    val numbers = List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
//    val res = numbers.foldLeft(0)((m, n) => m + n)
//    println(res) // 55

    val numbers = List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    val numberFunc = numbers.foldLeft(List[Int]()) _

    val squares = numberFunc((xs, x) => xs :+ x*x)
    println(squares) // List(1, 4, 9, 16, 25, 36, 49, 64, 81, 100)

    val cubes = numberFunc((xs, x) => xs :+ x*x*x)
    println(cubes)  // List(1, 8, 27, 64, 125, 216, 343, 512, 729, 1000)

    case class Message(sender: String, recipient: String, body: String)

    val message2 = Message("jorge@catalonia.es", "guillaume@quebec.ca", "Com va?")
    val message3 = Message("jorge@catalonia.es", "guillaume@quebec.ca", "Com va?")
    val messagesAreTheSame = message2 == message3  // true
    println(messagesAreTheSame)

    val message4 = Message("julien@bretagne.fr", "travis@washington.us", "Me zo o komz gant ma amezeg")
    val message5 = message4.copy(sender = message4.recipient, recipient = "claire@bourgogne.fr")
    println(message5.sender)  // travis@washington.us
    println(message5.recipient ) // claire@bourgogne.fr
    println(message5.body)  // "Me zo o komz gant ma amezeg"


    val x: Int = Random.nextInt(10)

    x match {
      case 0 => println("zero")
      case 1 => println("one")
      case 2 => println("two")
      case _ => println("other")
    }

    def matchTest(x: Int): String = x match {
      case 1 => "one"
      case 2 => "two"
      case _ => "other"
    }
    println(matchTest(3))  // prints other
    println(matchTest(1))  // prints one


//    abstract class Notification
//
//    case class Email(sender: String, title: String, body: String) extends Notification
//
//    case class SMS(caller: String, message: String) extends Notification
//
//    case class VoiceRecording(contactName: String, link: String) extends Notification
//
//    def showNotification(notification: Notification): String = {
//      notification match {
//        case Email(sender, title, _) =>
//          s"You got an email from $sender with title: $title"
//        case SMS(number, message) =>
//          s"You got an SMS from $number! Message: $message"
//        case VoiceRecording(name, link) =>
//          s"You received a Voice Recording from $name! Click the link to hear it: $link"
//      }
//    }
//    val someSms = SMS("12345", "Are you there?")
//    val someVoiceRecording = VoiceRecording("Tom", "voicerecording.org/id/123")
//
//    println(showNotification(someSms))  // prints You got an SMS from 12345! Message: Are you there?
//
//    println(showNotification(someVoiceRecording))  // prints You received a Voice Recording from Tom! Click the link to hear it: voicerecording.org/id/123



//    def showImportantNotification(notification: Notification, importantPeopleInfo: Seq[String]): String = {
//      notification match {
//        case Email(sender, _, _) if importantPeopleInfo.contains(sender) =>
//          "You got an email from special someone!"
//        case SMS(number, _) if importantPeopleInfo.contains(number) =>
//          "You got an SMS from special someone!"
//        case other =>
//          showNotification(other) // nothing special, delegate to our original showNotification function
//      }
//    }
//
//    val importantPeopleInfo = Seq("867-5309", "jenny@gmail.com")
//
//    val someSms = SMS("123-4567", "Are you there?")
//    val someVoiceRecording = VoiceRecording("Tom", "voicerecording.org/id/123")
//    val importantEmail = Email("jenny@gmail.com", "Drinks tonight?", "I'm free after 5!")
//    val importantSms = SMS("867-5309", "I'm here! Where are you?")

//    println(showImportantNotification(someSms, importantPeopleInfo)) // prints You got an SMS from 123-4567! Message: Are you there?
//    println(showImportantNotification(someVoiceRecording, importantPeopleInfo)) // prints You received a Voice Recording from Tom! Click the link to hear it: voicerecording.org/id/123
//    println(showImportantNotification(importantEmail, importantPeopleInfo)) // prints You got an email from special someone!
//
//    println(showImportantNotification(importantSms, importantPeopleInfo)) // prints You got an SMS from special someone!

    abstract class Device
    case class Phone(model: String) extends Device {
      def screenOff = "Turning screen off"
    }
    case class Computer(model: String) extends Device {
      def screenSaverOn = "Turning screen saver on..."
    }

    def goIdle(device: Device) = device match {
      case p: Phone => p.screenOff
      case c: Computer => c.screenSaverOn
    }

    sealed abstract class Furniture
    case class Couch() extends Furniture
    case class Chair() extends Furniture

    def findPlaceToSit(piece: Furniture): String = piece match {
      case a: Couch => "Lie on the couch"
      case b: Chair => "Sit on the chair"
    }


    case class Circle(radius: Double) {
      import Circle._
      def area: Double = calculateArea(radius)
    }
    object Circle {
      private def calculateArea(radius: Double): Double = Pi * pow(radius, 2.0)
    }
    val circle1 = Circle(5.0)
    println(circle1.area)


    class Email1(val username: String, val domainName: String)

    object Email1 {
      def fromString(emailString: String): Option[Email1] = {
        emailString.split('@') match {
          case Array(a, b) => Some(new Email1(a, b))
          case _ => None
        }
      }
    }

    val scalaCenterEmail = Email1.fromString("scala.center@epfl.ch")
    scalaCenterEmail match {
      case Some(email) => println(
        s"""Registered an email
           |Username: ${email.username}
           |Domain name: ${email.domainName}
     """.stripMargin)
      case None => println("Error: could not parse email")
    }


    val numberPattern: Regex = "[0-9]".r

    numberPattern.findFirstMatchIn("awesomepassword") match {
      case Some(_) => println("Password OK")
      case None => println("Password must contain a number")
    }

    val keyValPattern: Regex = "([0-9a-zA-Z- ]+): ([0-9a-zA-Z-#()/. ]+)".r

    val input: String =
      """background-color: #A03300;
        |background-image: url(img/header100.png);
        |background-position: top center;
        |background-repeat: repeat-x;
        |background-size: 2160px 108px;
        |margin: 0;
        |height: 108px;
        |width: 100%;""".stripMargin

    for (patternMatch <- keyValPattern.findAllMatchIn(input))
      println(s"key: ${patternMatch.group(1)} value: ${patternMatch.group(2)}")


  }
}
