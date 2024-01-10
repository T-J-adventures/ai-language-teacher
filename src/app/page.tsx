import Link from "next/link";

export default function Home() {
  return (
      <main className="flex min-h-screen flex-col items-center justify-between p-10">
          <div className="">
              <Link href={ "/me" }>Show Me!</Link>
      </div>
    </main>
  )
}
