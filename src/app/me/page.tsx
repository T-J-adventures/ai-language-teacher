import { signOut } from "auth";
import { auth } from "auth";
import Image from "next/image";

export default async function Page() {
    const session = await auth()
    return (
        <div className="flex flex-col items-center place-content-center h-screen">
            <div className="avatar">
                <div className="w-24 rounded-full">
                    <Image src={ session?.user?.image || "" } alt="Avatar" width={ 100 } height={ 100 }></Image>
                </div>
            </div>

            <div>Hello World, this is { session?.user?.name }!</div>

            <form
                action={ async () => {
                    "use server"
                    await signOut()
                } }
                className="block"
            >
                <button className="px-4 py-2 my-2 bg-primary text-primary-foreground hover:bg-primary/90">
                    Sign Out
                </button>
            </form>

        </div>
    )
}
